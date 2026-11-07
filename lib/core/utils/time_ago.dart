import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Social-style relative time: `now`, `5m`, `3h`, `2d`, then `12 Oct`
/// (or `12 Oct 2025` for another year).
abstract final class TimeAgo {
  static const _locale = 'en_social';
  static var _registered = false;

  static String format(DateTime date, {DateTime? now}) {
    final clock = now ?? DateTime.now();
    final diff = clock.difference(date);
    if (diff.inDays >= 7 || diff.isNegative) {
      final local = date.toLocal();
      return local.year == clock.toLocal().year
          ? DateFormat('d MMM').format(local)
          : DateFormat('d MMM y').format(local);
    }
    if (!_registered) {
      timeago.setLocaleMessages(_locale, _SocialMessages());
      _registered = true;
    }
    return timeago.format(date, clock: clock, locale: _locale);
  }
}

class _SocialMessages extends timeago.EnShortMessages {
  @override
  String aboutAMinute(int minutes) => '1m';
  @override
  String aboutAnHour(int minutes) => '1h';
  @override
  String aDay(int hours) => '1d';
}
