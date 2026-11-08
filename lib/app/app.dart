import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/config/app_config.dart';
import 'package:petalsinajar/app/push/push_bridge.dart';
import 'package:petalsinajar/app/push/push_registration_check.dart';
import 'package:petalsinajar/app/router/app_router.dart';
import 'package:petalsinajar/app/theme/app_theme.dart';
import 'package:petalsinajar/app/theme/theme_mode.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themes = ref.watch(appThemesProvider);
    final useMocks = ref.watch(appConfigProvider).useMocks;
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Petalsinajar',
      debugShowCheckedModeBanner: false,
      theme: themes.light,
      darkTheme: themes.dark,
      themeMode: ref.watch(appThemeModeProvider),
      routerConfig: router,
      builder: (context, child) {
        final app = PushBridge(
          router: router,
          child: PushRegistrationCheck(
            navigatorKey: router.routerDelegate.navigatorKey,
            child: child!,
          ),
        );
        // Demo data lives in memory and resets on restart; make that obvious
        // so nobody mistakes it for the live API.
        return useMocks
            ? Banner(
                message: 'DEMO',
                location: BannerLocation.topEnd,
                child: app,
              )
            : app;
      },
    );
  }
}
