import 'package:petalsinajar/core/mock/mock_delay.dart';
import 'package:petalsinajar/core/mock/mock_pagination.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/features/feed/data/feed_source.dart';
import 'package:uuid/uuid.dart';

/// Answers with the backend's JSON (`PostPresenter`, comment rows) built from
/// the seed posts. Likes and comments live in memory until restart.
///
/// The seed has no follow graph, so "following" is posts from the events
/// the viewer belongs to; "for you" ranks every post by likes, as the
/// server ranks by score.
class FeedMockSource implements FeedSource {
  FeedMockSource({
    required SeedLoader seed,
    required MockDelay delay,
    required String viewerId,
    DateTime Function()? clock,
  }) : _seed = seed,
       _delay = delay,
       _viewerId = viewerId,
       _clock = clock ?? DateTime.now;

  final SeedLoader _seed;
  final MockDelay _delay;
  final String _viewerId;
  final DateTime Function() _clock;

  late Map<String, Json> _users;
  late Map<String, Json> _vendors;
  late Map<String, Json> _events;
  List<Json>? _posts;

  /// Post id → whether the viewer likes it, once they've changed it.
  final _likes = <String, bool>{};
  final _likeCounts = <String, int>{};
  final _comments = <String, List<Json>>{};

  Future<List<Json>> _load() async {
    if (_posts case final posts?) return posts;
    final [posts, users, vendors, events] = await Future.wait([
      _seed.load('posts'),
      _seed.load('users'),
      _seed.load('vendors'),
      _seed.load('events'),
    ]);
    _users = {for (final u in users) u['id'] as String: u};
    _vendors = {for (final v in vendors) v['id'] as String: v};
    _events = {for (final e in events) e['id'] as String: e};
    return _posts = posts;
  }

  Json? _find(String postId) =>
      _posts!.where((p) => p['id'] == postId).firstOrNull;

  Future<Json> _post(String postId) async {
    await _load();
    return _find(postId) ??
        (throw const ApiException(
          type: ApiErrorType.notFound,
          message: 'Post not found',
          statusCode: 404,
        ));
  }

  /// `ActorResource`.
  Json _actor(String type, String id) {
    final isVendor = type == 'vendor';
    final row = isVendor ? _vendors[id] : _users[id];
    final image = row?[isVendor ? 'logo' : 'avatar'] as Json?;
    return {
      'type': type,
      'id': id,
      'handle': row?['handle'],
      'name': row?['name'],
      'avatar_url': image?['url'],
      'is_verified': isVendor && (row?['verified'] ?? false) == true,
    };
  }

  bool _liked(Json p) =>
      _likes[p['id']] ?? (p['viewer_has_liked'] ?? false) == true;

  int _likeCount(Json p) =>
      _likeCounts[p['id']] ?? p['like_count'] as int? ?? 0;

  int _commentCount(Json p) =>
      (p['comment_count'] as int? ?? 0) + (_comments[p['id']]?.length ?? 0);

  /// `PostPresenter::present`.
  Json _present(Json p) {
    final author = p['author'] as Json;
    final event = _events[p['event_id']];
    return {
      'id': p['id'],
      'author': _actor(author['type'] as String, author['id'] as String),
      'event': event == null
          ? null
          : {'id': event['id'], 'title': event['title'], 'type': event['type']},
      'event_type': event?['type'],
      'kind': 'post',
      'caption': p['caption'],
      'hashtags': <String>[],
      'media': [
        for (final m in (p['media'] as List).cast<Json>())
          {
            'url': m['url'],
            'type': 'image',
            'w': m['width'],
            'h': m['height'],
            'blurhash': m['blurhash'],
            'tags': <Json>[],
          },
      ],
      'visibility': 'public',
      'counts': {
        'likes': _likeCount(p),
        'comments': _commentCount(p),
        'saves': p['save_count'] ?? 0,
      },
      'my_reaction': _liked(p) ? 'like' : null,
      'created_at': p['created_at'],
    };
  }

  Json _page(List<Json> rows, String? cursor) {
    final page = paginateList(rows, cursor: cursor);
    return {'data': page.items, 'next_cursor': page.nextCursor};
  }

  bool _isMember(Json? event) =>
      event != null &&
      (event['host_id'] == _viewerId ||
          (event['co_host_ids'] as List).contains(_viewerId) ||
          (event['guests'] as List).any(
            (g) => (g as Json)['user_id'] == _viewerId,
          ));

  @override
  Future<Json> discover({String? cursor}) async {
    final posts = await _load();
    await _delay();
    final ranked = [...posts]
      ..sort((a, b) {
        final byLikes = _likeCount(b).compareTo(_likeCount(a));
        return byLikes != 0 ? byLikes : '${b['id']}'.compareTo('${a['id']}');
      });
    return _page([for (final p in ranked) _present(p)], cursor);
  }

  @override
  Future<Json> following({String? cursor}) async {
    final posts = await _load();
    await _delay();
    final mine = [
      for (final p in posts)
        if (_isMember(_events[p['event_id']])) p,
    ]..sort((a, b) => '${b['created_at']}'.compareTo('${a['created_at']}'));
    return _page([for (final p in mine) _present(p)], cursor);
  }

  Future<Json> _setLike(String postId, {required bool liked}) async {
    final p = await _post(postId);
    await _delay();
    if (_liked(p) != liked) {
      _likeCounts[postId] = _likeCount(p) + (liked ? 1 : -1);
      _likes[postId] = liked;
    }
    return {'likes': _likeCount(p), 'my_reaction': liked ? 'like' : null};
  }

  @override
  Future<Json> react(String postId) => _setLike(postId, liked: true);

  @override
  Future<Json> unreact(String postId) => _setLike(postId, liked: false);

  @override
  Future<Json> comments(String postId, {String? cursor}) async {
    await _post(postId);
    await _delay();
    return _page(_comments[postId] ?? const [], cursor);
  }

  @override
  Future<Json> addComment(String postId, String body) async {
    await _post(postId);
    await _delay();
    if (body.trim().isEmpty) {
      throw const ApiException(
        type: ApiErrorType.validation,
        message: 'The body field is required.',
        statusCode: 422,
        fieldErrors: {
          'body': ['The body field is required.'],
        },
      );
    }
    final comment = {
      'id': const Uuid().v4(),
      'post_id': postId,
      'parent_id': null,
      'author': _actor('user', _viewerId),
      'body': body.trim(),
      'likes': 0,
      'replies': 0,
      'created_at': _clock().toUtc().toIso8601String(),
    };
    (_comments[postId] ??= []).add(comment);
    return comment;
  }
}
