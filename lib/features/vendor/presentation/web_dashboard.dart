import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';
import 'package:petalsinajar/features/profile/presentation/dashboard_sign_in_screen.dart';
import 'package:url_launcher/url_launcher.dart';

/// Pages of the web dashboard (Filament, at `/vendor/{handle}`), for what
/// the app can't do yet. Items is one page: "New item" and "Edit" open as
/// pop-ups there, so there are no per-item addresses to link to.
abstract final class WebDashboard {
  static const _base = 'https://petalsinajar.com/vendor';

  /// The business's dashboard home.
  static Uri home(String handle) => Uri.parse('$_base/$handle');

  static Uri items(String handle) => Uri.parse('$_base/$handle/items');

  /// The items page, where "New item" is.
  static Uri newItem(String handle) => items(handle);

  /// The items page searched down to [title], one tap from "Edit".
  static Uri editItem(String handle, String title) => Uri.parse(
    '$_base/$handle/items',
  ).replace(queryParameters: {'search': title});
}

/// Opens [url] in the browser; if none opens, copies it and says so.
/// Without a web sign-in the dashboard can't be entered, so that's set up
/// first instead.
Future<void> openWebDashboard(BuildContext context, Uri url) async {
  final me = ProviderScope.containerOf(context).read(authSessionProvider).value;
  if (me != null && !me.hasDashboardSignIn) {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const DashboardSignInScreen()),
    );
    return;
  }
  if (!context.mounted) return;
  final messenger = ScaffoldMessenger.of(context);
  var opened = false;
  try {
    opened = await launchUrl(url, mode: LaunchMode.externalApplication);
  } on Object {
    opened = false;
  }
  if (opened) return;
  await Clipboard.setData(ClipboardData(text: url.toString()));
  messenger.showSnackBar(
    SnackBar(
      content: Text('Link copied. Open it in a browser: $url'),
    ),
  );
}
