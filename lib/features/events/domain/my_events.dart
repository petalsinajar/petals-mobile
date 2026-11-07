import 'package:petalsinajar/features/events/domain/event.dart';

/// The three tabs of My Events.
enum MyEventsBucket { upcoming, planning, past }

/// Which tab [event] belongs in at [now], or `null` to hide it.
///
/// Available: `event.viewerRole` (host / coHost / guest / none),
/// `event.viewerRsvp` (going / maybe / declined / invited / null),
/// `event.viewerIsHosting`, `event.startsAt`, `event.effectiveEndsAt`.
///
/// * Hosting (host or co-host) and not over yet → planning.
/// * Invited, not over, and not declined → upcoming (unanswered invites
///   included, so they're easy to RSVP to).
/// * Over (past its end, not its start — a party in progress stays put)
///   and hosted or attended (going / maybe) → past.
/// * Declined, unanswered-and-over, or unrelated → hidden.
MyEventsBucket? bucketOf(Event event, DateTime now) {
  final isOver = !now.isBefore(event.effectiveEndsAt);
  final rsvp = event.viewerRsvp;

  if (event.viewerIsHosting) {
    return isOver ? MyEventsBucket.past : MyEventsBucket.planning;
  }
  if (event.viewerRole != ViewerRole.guest || rsvp == RsvpStatus.declined) {
    return null;
  }
  if (!isOver) return MyEventsBucket.upcoming;
  final attended = rsvp == RsvpStatus.going || rsvp == RsvpStatus.maybe;
  return attended ? MyEventsBucket.past : null;
}

/// Groups [events] by bucket. Upcoming and planning are soonest first,
/// past is most recent first.
Map<MyEventsBucket, List<Event>> groupMyEvents(
  List<Event> events,
  DateTime now,
) {
  final groups = {for (final b in MyEventsBucket.values) b: <Event>[]};
  for (final event in events) {
    final bucket = bucketOf(event, now);
    if (bucket != null) groups[bucket]!.add(event);
  }
  for (final MapEntry(:key, :value) in groups.entries) {
    value.sort(
      (a, b) => key == MyEventsBucket.past
          ? b.startsAt.compareTo(a.startsAt)
          : a.startsAt.compareTo(b.startsAt),
    );
  }
  return groups;
}
