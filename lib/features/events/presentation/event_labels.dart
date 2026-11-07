import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/domain/event_plan.dart';
import 'package:petalsinajar/features/events/domain/event_type.dart';

/// User-facing text and icons for event enums.
extension EventTypeLabel on EventType {
  String get label => switch (this) {
    EventType.wedding => 'Wedding',
    EventType.birthday => 'Birthday',
    EventType.corporate => 'Corporate',
  };

  String get tagline => switch (this) {
    EventType.wedding => 'White weddings, engagements, receptions',
    EventType.birthday => 'Kids parties, milestones, surprise nights',
    EventType.corporate => 'Launches, summits, staff parties',
  };

  IconData get icon => switch (this) {
    EventType.wedding => Icons.favorite_rounded,
    EventType.birthday => Icons.cake_rounded,
    EventType.corporate => Icons.business_center_rounded,
  };
}

extension EventVisibilityLabel on EventVisibility {
  String get label => switch (this) {
    EventVisibility.public => 'Public',
    EventVisibility.guests => 'Guests only',
    EventVisibility.private => 'Private',
  };

  String get description => switch (this) {
    EventVisibility.public => 'Anyone can find it and see the feed.',
    EventVisibility.guests => 'Only people you invite can see it.',
    EventVisibility.private => 'Just you and your co-hosts, for planning.',
  };

  IconData get icon => switch (this) {
    EventVisibility.public => Icons.public_rounded,
    EventVisibility.guests => Icons.group_rounded,
    EventVisibility.private => Icons.lock_rounded,
  };
}

extension RsvpStatusLabel on RsvpStatus {
  String get label => switch (this) {
    RsvpStatus.going => 'Going',
    RsvpStatus.maybe => 'Maybe',
    RsvpStatus.declined => "Can't go",
    RsvpStatus.invited => 'Invited',
  };

  IconData get icon => switch (this) {
    RsvpStatus.going => Icons.check_circle_rounded,
    RsvpStatus.maybe => Icons.help_rounded,
    RsvpStatus.declined => Icons.cancel_rounded,
    RsvpStatus.invited => Icons.mail_rounded,
  };
}

extension BookingStatusLabel on BookingStatus {
  String get label => switch (this) {
    BookingStatus.pendingVendor => 'Awaiting vendor',
    BookingStatus.accepted => 'Accepted',
    BookingStatus.confirmed => 'Confirmed',
    BookingStatus.outForDelivery => 'On the way',
    BookingStatus.delivered => 'Delivered',
    BookingStatus.returned => 'Returned',
    BookingStatus.completed => 'Completed',
    BookingStatus.declined => 'Declined',
    BookingStatus.expired => 'Expired',
    BookingStatus.cancelled => 'Cancelled',
    BookingStatus.disputed => 'Disputed',
  };

  bool get isProblem => switch (this) {
    BookingStatus.declined ||
    BookingStatus.expired ||
    BookingStatus.cancelled ||
    BookingStatus.disputed => true,
    _ => false,
  };
}

abstract final class EventDates {
  /// `Sat 12 Dec · 2:00 PM`
  static String startLine(DateTime startsAt) =>
      DateFormat('EEE d MMM · h:mm a').format(startsAt.toLocal());

  /// `12 Dec` or `12–13 Dec`
  static String range(DateTime start, DateTime end) {
    final s = start.toLocal();
    final e = end.toLocal();
    if (s.year == e.year && s.month == e.month && s.day == e.day) {
      return DateFormat('d MMM').format(s);
    }
    return s.month == e.month
        ? '${s.day}–${DateFormat('d MMM').format(e)}'
        : '${DateFormat('d MMM').format(s)} – ${DateFormat('d MMM').format(e)}';
  }
}
