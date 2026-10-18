/* coi_pond
 * Copyright (c) 2026 YWT. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './screens/export.dart';
import './utils/export.dart';

import 'package:a11how/main.dart' as a11;
import 'package:sos/main.dart' as sos;

import 'package:open_ui/open_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define the router //

final List<RouteBase> routes = <RouteBase>[
  // Home
  GoRoute(
    path: '/',
    name: '/',
    pageBuilder: (BuildContext pbc, GoRouterState pbs) =>
        ezPageBuilder(configWatcher(pbc), pbc, pbs, const HomeScreen()),
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (_, __, StatefulNavigationShell curr) => curr,
        branches: <StatefulShellBranch>[
          StatefulShellBranch(routes: a11.routes),
          StatefulShellBranch(routes: sos.routes),
        ],
      ),

      // Settings
      GoRoute(
        path: settingsHubPath,
        name: settingsHubPath,
        pageBuilder: (BuildContext pbc, GoRouterState pbs) =>
            ezPageBuilder(configWatcher(pbc), pbc, pbs, const SettingsHubScreen()),
      ),
    ],
  ),
];

// Define the app //

class CoiPond extends StatelessWidget {
  final Locale storedLocale;
  final OUILang storedOUILang;
  final Lang storedLang;

  const CoiPond(
    this.storedLocale,
    this.storedOUILang,
    this.storedLang, {
    super.key,
  });

  @override
  Widget build(BuildContext context) => EzConfigurableApp(
        localizationsDelegates: ezLocalizationsDelegates(Lang.localizationsDelegates),
        supportedLocales: Lang.supportedLocales,
        locale: storedLocale,
        el10n: storedOUILang,
        appCache: CoiPondCache(storedLocale, storedLang),
        routerConfig: GoRouter(
          navigatorKey: ezRootNav,
          initialLocation: '/',
          errorBuilder: (_, GoRouterState state) => const ErrorScreen(),
          routes: routes,
        ),
      );
}

void main() async {
  // Configure the environment //

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

  EzCM.init(
    appName: appName,
    androidPackage: androidPackage,
    assetPaths: <String>{},
    orientations: DeviceOrientation.values,
    localeFallback: americanEnglish,
    l10nFallback: await OUILang.delegate.load(americanEnglish),
    preferences: await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(
        allowList: allEZConfigKeys.keys.toSet(),
      ),
    ),
    defaults: isMobile() ? ywtMobileConfig : ywtDesktopConfig,
  );

  // Run the app //

  final (Locale storedLocale, OUILang storedOUILang) = await ezStoredL10n();

  runApp(CoiPond(
    storedLocale,
    storedOUILang,
    await Lang.delegate.load(storedLocale),
  ));
}
