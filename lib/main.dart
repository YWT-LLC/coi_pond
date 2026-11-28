/* coi_pond
 * Copyright (c) 2026 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './screens/export.dart';
import './utils/export.dart';

import 'package:open_ui/open_ui.dart';
import 'package:presents/firebase_options.dart';
import 'package:presents/services/export.dart' show Presenter;

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define the router //

final List<RouteBase> routes = <RouteBase>[
  // Settings
  GoRoute(
    path: settingsScreenPath,
    name: settingsScreenName,
    pageBuilder: (BuildContext pbc, GoRouterState pbs) =>
        ezPageBuilder(configWatcher(pbc), pbc, pbs, const SettingsHubScreen()),
  ),

  ...Module.values.map((Module module) => GoRoute(
        path: module.path,
        name: module.name,
        pageBuilder: (BuildContext pbc, GoRouterState pbs) =>
            ezPageBuilder(configWatcher(pbc), pbc, pbs, module.homeScreen),
        routes: module.routes,
      )),
];

// Define the app //

class CoiPond extends StatelessWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore db;
  final Locale storedLocale;
  final OUILang storedOUILang;
  final Lang storedLang;

  const CoiPond(
    this.auth,
    this.db,
    this.storedLocale,
    this.storedOUILang,
    this.storedLang, {
    super.key,
  });

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<Presenter>(
        create: (_) => Presenter(auth: auth, db: db),
        child: _TheMagic(storedLocale, storedOUILang, storedLang),
      );
}

class _TheMagic extends StatelessWidget {
  final Locale storedLocale;
  final OUILang storedOUILang;
  final Lang storedLang;

  const _TheMagic(this.storedLocale, this.storedOUILang, this.storedLang);

  @override
  Widget build(BuildContext context) => EzConfigurableApp(
        localizationsDelegates: ezLocalizationsDelegates(Lang.localizationsDelegates),
        supportedLocales: Lang.supportedLocales,
        locale: storedLocale,
        el10n: storedOUILang,
        appCache: CoiPondCache(storedLocale, storedLang),
        routerConfig: GoRouter(
          navigatorKey: ezRootNav,
          initialLocation: homePath,
          errorBuilder: (_, GoRouterState state) => const ErrorScreen(),
          routes: <RouteBase>[
            // Home
            GoRoute(
              path: homePath,
              name: homeName,
              pageBuilder: (BuildContext pbc, GoRouterState pbs) =>
                  ezPageBuilder(configWatcher(pbc), pbc, pbs, const HomeScreen()),
              routes: routes,
            ),
          ],
        ),
      );
}

void main() async {
  // Configure the environment //

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  EzManager.init(
    appName: appName,
    androidPackage: androidPackage,
    assetPaths: Module.values.fold<Set<String>>(
      <String>{},
      (Set<String> acc, Module module) => <String>{...acc, ...module.assetPaths},
    ),
    orientations: DeviceOrientation.values,
    localeFallback: americanEnglish,
    l10nFallback: await OUILang.delegate.load(americanEnglish),
    preferences: await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(
        allowList: Module.values.fold<Set<String>>(
          allEzConfigPairs.keys.toSet(),
          (Set<String> acc, Module module) => <String>{...acc, ...module.uniqueKeys},
        ),
      ),
    ),
    defaults: Module.values.fold<Map<String, dynamic>>(
      isMobile() ? ywtMobileConfig : ywtDesktopConfig,
      (Map<String, dynamic> acc, Module module) =>
          <String, dynamic>{...acc, ...module.uniqueDefaults},
    ),
    neverReset: Module.values.fold<Set<String>>(
      <String>{},
      (Set<String> acc, Module module) => <String>{...acc, ...module.neverResetKeys},
    ),
  );

  await setMinWindow();

  // Run the app //

  final (Locale storedLocale, OUILang storedOUILang) = await ezStoredL10n();

  runApp(CoiPond(
    FirebaseAuth.instance,
    FirebaseFirestore.instance,
    storedLocale,
    storedOUILang,
    await Lang.delegate.load(storedLocale),
  ));
}
