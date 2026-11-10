import 'package:petalsinajar/core/media/media.dart';
import 'package:petalsinajar/core/media/media_limits.dart';

/// What the media will be used for; the server checks it's allowed there.
enum MediaPurpose {
  post,
  item,
  avatar,
  cover,
  eventCover
  ;

  /// `event_cover` for [eventCover].
  String get wire => this == eventCover ? 'event_cover' : name;
}

/// One part of a multipart upload.
class UploadPart {
  const UploadPart({
    required this.number,
    required this.url,
    required this.bytes,
  });

  final int number;
  final String url;
  final int bytes;
}

/// How to send the file, as the server planned it:
/// * single: PUT [url] with exactly [headers];
/// * multipart: PUT each of [parts], keeping each ETag for `complete`;
/// * form: POST [url] as multipart/form-data with the file in [field].
class UploadPlan {
  const UploadPlan({
    required this.method,
    this.url,
    this.headers = const {},
    this.parts = const [],
    this.field,
  });

  final String method;
  final String? url;
  final Map<String, String> headers;
  final List<UploadPart> parts;
  final String? field;

  bool get isMultipart => parts.isNotEmpty;
  bool get isForm => method.toUpperCase() == 'POST';
}

class UploadTicket {
  const UploadTicket({required this.mediaId, required this.plan});

  final String mediaId;
  final UploadPlan plan;
}

/// A finished part: its number and the ETag storage gave back.
typedef CompletedPart = ({int number, String etag});

/// Reports bytes sent so far out of the total.
typedef UploadProgress = void Function(int sent, int total);

/// The upload API (`/v1/uploads`, `/v1/media`) and direct transfers to
/// storage. Files never go through the API itself.
abstract interface class MediaRepository {
  /// `POST /v1/uploads`: reserves a media id and returns the upload plan.
  Future<UploadTicket> request(
    PreparedFile file, {
    required MediaPurpose purpose,
    String? vendorId,
  });

  /// Sends the file as [plan] says. For multipart, returns each part's ETag;
  /// parts already in [done] are skipped (resuming).
  Future<List<CompletedPart>> transfer(
    PreparedFile file,
    UploadPlan plan, {
    UploadProgress? onProgress,
    List<CompletedPart> done = const [],
    void Function(CompletedPart part)? onPartDone,
  });

  /// `POST /v1/uploads/{id}/complete`.
  Future<Media> complete(String mediaId, {List<CompletedPart> parts});

  /// `GET /v1/media/{id}`: status and, once ready, URLs.
  Future<Media> get(String mediaId);
}

/// Thrown when the server refuses the file (`422` on request), with the
/// server's own words.
class MediaRejected extends MediaUploadException {
  const MediaRejected(super.message);
}
