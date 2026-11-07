import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/router/app_router.dart';
import 'package:petalsinajar/app/theme/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themes = ref.watch(appThemesProvider);
    return MaterialApp.router(
      title: 'Petalsinajar',
      debugShowCheckedModeBanner: false,
      theme: themes.light,
      darkTheme: themes.dark,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
