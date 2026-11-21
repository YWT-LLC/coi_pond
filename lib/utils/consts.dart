/* coi_pond
 * Copyright (c) 2026 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:open_ui/open_ui.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

// import 'package:presents/main.dart' as presents_main;
// import 'package:presents/screens/export.dart' as presents_screens;
// import 'package:presents/utils/export.dart' as presents_utils;

import 'package:example/main.dart' as oui_main;
import 'package:example/screens/export.dart' as oui_screens;
import 'package:example/utils/export.dart' as oui_utils;

import 'package:sos/main.dart' as sos_main;
import 'package:sos/screens/export.dart' as sos_screens;
import 'package:sos/utils/export.dart' as sos_utils;

import 'package:a11how/main.dart' as a11how_main;
import 'package:a11how/screens/export.dart' as a11how_screens;
import 'package:a11how/utils/export.dart' as a11how_utils;

// import 'package:krotos_chronus/main.dart' as krotos_main;
// import 'package:krotos_chronus/screens/export.dart' as krotos_screens;
// import 'package:krotos_chronus/utils/export.dart' as krotos_utils;

// import 'package:wyrd_web/main.dart' as ww_main;
// import 'package:wyrd_web/screens/export.dart' as ww_screens;
// import 'package:wyrd_web/utils/export.dart' as ww_utils;

// import 'package:smoke_signal/main.dart' as signal_main;
// import 'package:smoke_signal/screens/export.dart' as signal_screens;
// import 'package:smoke_signal/utils/export.dart' as signal_utils;

/// COI POND
const String appName = 'COI POND';

/// llc.ywt.coi_pond
const String androidPackage = 'llc.ywt.coi_pond';

enum Module {
  // presents,
  oui,
  sos,
  a11how,
  // krotos,
  // ww,
  // signal,
}

extension ModCon on Module {
  Set<TargetPlatform> get platforms => switch (this) {
        // Presents - not fuchsia
        // Module.presents => <TargetPlatform>{
        //     TargetPlatform.android,
        //     TargetPlatform.iOS,
        //     TargetPlatform.linux,
        //     TargetPlatform.macOS,
        //     TargetPlatform.windows,
        //   },

        // Open UI - not fuchsia
        Module.oui => <TargetPlatform>{
            TargetPlatform.android,
            TargetPlatform.iOS,
            TargetPlatform.linux,
            TargetPlatform.macOS,
            TargetPlatform.windows,
          },

        // InstaSOS - mobile
        Module.sos => <TargetPlatform>{
            TargetPlatform.android,
            TargetPlatform.iOS,
          },

        // a11how - not fuchsia
        Module.a11how => <TargetPlatform>{
            TargetPlatform.android,
            TargetPlatform.iOS,
            TargetPlatform.linux,
            TargetPlatform.macOS,
            TargetPlatform.windows,
          },

        // Krotos Chronus - not fuchsia
        // Module.krotos => <TargetPlatform>{
        //     TargetPlatform.android,
        //     TargetPlatform.iOS,
        //     TargetPlatform.linux,
        //     TargetPlatform.macOS,
        //     TargetPlatform.windows,
        //   },

        // Wyrd Web - not fuchsia
        // Module.ww => <TargetPlatform>{
        //     TargetPlatform.android,
        //     TargetPlatform.iOS,
        //     TargetPlatform.linux,
        //     TargetPlatform.macOS,
        //     TargetPlatform.windows,
        //   },

        // Smoke Signal - not fuchsia
        // Module.signal => <TargetPlatform>{
        //     TargetPlatform.android,
        //     TargetPlatform.iOS,
        //     TargetPlatform.linux,
        //     TargetPlatform.macOS,
        //     TargetPlatform.windows,
        //   },
      };

  Set<String> get assetPaths => switch (this) {
        // Module.presents => presents_utils.assetPaths,
        Module.oui => <String>{},
        Module.sos => sos_utils.assetPaths,
        Module.a11how => <String>{},
        // krotos => krotos_utils.assetPaths,
        // wyrd_web => ww_utils.assetPaths,
        // smoke_signal => smoke_signal_utils.assetPaths,
      };

  Map<String, Type> get uniquePairs => switch (this) {
        // Module.presents => presents_utils.uniquePairs,
        Module.oui => oui_utils.uniquePairs,
        Module.sos => sos_utils.uniquePairs,
        Module.a11how => a11how_utils.uniquePairs,
        // krotos => krotos_utils.uniquePairs,
        // wyrd_web => ww_utils.uniquePairs,
        // smoke_signal => smoke_signal_utils.uniquePairs,
      };

  Map<String, Object> get uniqueDefaults => switch (this) {
        // Module.presents => presents_utils.uniqueDefaults,
        Module.oui => oui_utils.uniqueDefaults,
        Module.sos => sos_utils.uniqueDefaults,
        Module.a11how => a11how_utils.uniqueDefaults,
        // krotos => krotos_utils.uniqueDefaults,
        // wyrd_web => ww_utils.uniqueDefaults,
        // smoke_signal => smoke_signal_utils.uniqueDefaults,
      };

  Set<String> get uniqueKeys => uniquePairs.keys.toSet();

  Map<String, Type> get neverResetPairs => switch (this) {
        // Module.presents => presents_utils.neverResetPairs,
        Module.oui => <String, Type>{},
        Module.sos => sos_utils.neverResetPairs,
        Module.a11how => a11how_utils.neverResetPairs,
        // krotos => krotos_utils.neverResetPairs,
        // wyrd_web => ww_utils.neverResetPairs,
        // smoke_signal => smoke_signal_utils.neverResetPairs,
      };

  Set<String> get neverResetKeys => neverResetPairs.keys.toSet();

  IconData get icon => switch (this) {
        // Module.presents => Icons.card_giftcard,
        Module.oui => Icons.create,
        Module.sos => Icons.notifications_active,
        Module.a11how => Icons.translate,
        // krotos => Icons.IDK,
        // wyrd_web => Icons.IDK,
        // smoke_signal => Icons.IDK,
      };

  String get path => switch (this) {
        // Module.presents => 'presents',
        Module.oui => 'oui',
        Module.sos => 'sos',
        Module.a11how => 'a11how',
        // krotos => 'krotos',
        // ww => 'ww',
        // signal, => 'signal',
      };

  String get name => switch (this) {
        // Module.presents => 'Presents',
        Module.oui => 'Open UI',
        Module.sos => 'InstaSOS',
        Module.a11how => 'a11how',
        // krotos => 'Krotos Chronus',
        // wyrd_web => 'Wyrd Web',
        // smoke_signal => 'Smoke Signal',
      };

  List<RouteBase> get routes => switch (this) {
        // Module.presents => presents_main.routes,
        Module.oui => oui_main.routes,
        Module.sos => sos_main.routes,
        Module.a11how => a11how_main.routes,
        // krotos => krotos_main.routes,
        // ww => ww_main.routes,
        // signal => signal_main.routes,
      };

  Widget get homeScreen => switch (this) {
        // Module.presents => const presents_screens.HomeScreen(),
        Module.oui => const oui_screens.HomeScreen(),
        Module.sos => const sos_screens.HomeScreen(),
        Module.a11how => const a11how_screens.HomeScreen(),
        // krotos => const krotos_screens.HomeScreen(),
        // ww => const ww_screens.HomeScreen(),
        // signal => const signal_screens.HomeScreen(),
      };

  Future<EzAppCache> cache(EzProvider config) async => switch (this) {
        // Presents
        // Module.presents => presents_utils.PresentsCache(
        //     config.locale,
        //     await presents_utils.Lang.delegate.load(config.locale),
        //   ),

        // Open UI
        Module.oui => oui_utils.OpenUICache(
            config.locale,
            await oui_utils.Lang.delegate.load(config.locale),
          ),

        // InstaSOS
        Module.sos => sos_utils.SOSCache(
            config.locale,
            await sos_utils.Lang.delegate.load(config.locale),
          ),

        // a11how
        Module.a11how => a11how_utils.A11howCache(
            config.locale,
            await a11how_utils.Lang.delegate.load(config.locale),
          ),

        // Krotos Chronus
        // Module.krotos => krotos_utils.A11howCache(
        //     config.locale,
        //     await krotos_utils.Lang.delegate.load(config.locale),
        //   ),

        // Wyrd Web
        // Module.ww => ww_utils.A11howCache(
        //     config.locale,
        //     await ww_utils.Lang.delegate.load(config.locale),
        //   ),

        // Smoke Signal
        // Module.signal => signal_utils.A11howCache(
        //     config.locale,
        //     await signal_utils.Lang.delegate.load(config.locale),
        //   ),
      };
}
