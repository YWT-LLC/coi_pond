/* coi_pond
 * Copyright (c) 2026 YWT. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

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

// import 'package:ojnt/main.dart' as ojnt_main;
// import 'package:ojnt/screens/export.dart' as ojnt_screens;
// import 'package:ojnt/utils/export.dart' as ojnt_utils;

import 'package:open_ui/open_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// COI POND
const String appName = 'COI POND';

/// llc.ywt.coi_pond
const String androidPackage = 'llc.ywt.coi_pond';

enum Module {
  oui,
  sos,
  a11how,
  // krotos,
  // ww,
  // signal,
  // ojnt,
}

extension ModCon on Module {
  Set<TargetPlatform> get platforms => switch (this) {
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

        // OJNT - not fuchsia
        // Module.ojnt => <TargetPlatform>{
        //     TargetPlatform.android,
        //     TargetPlatform.iOS,
        //     TargetPlatform.linux,
        //     TargetPlatform.macOS,
        //     TargetPlatform.windows,
        //   },
      };

  IconData get icon => switch (this) {
        Module.oui => Icons.create,
        Module.sos => Icons.notifications_active,
        Module.a11how => Icons.translate,
        // krotos => Icons.IDK,
        // wyrd_web => Icons.IDK,
        // smoke_signal => Icons.IDK,
        // ojnt => Icons.IDK,
      };

  String get path => switch (this) {
        Module.oui => 'oui',
        Module.sos => 'sos',
        Module.a11how => 'a11how',
        // krotos => 'krotos',
        // ww => 'ww',
        // signal, => 'signal',
        // ojnt => 'ojnt',
      };

  String get name => switch (this) {
        Module.oui => 'Open UI',
        Module.sos => 'InstaSOS',
        Module.a11how => 'a11how',
        // krotos => 'Krotos Chronus',
        // wyrd_web => 'Wyrd Web',
        // smoke_signal => 'Smoke Signal',
        // ojnt => 'OJNT',
      };

  List<RouteBase> get routes => switch (this) {
        Module.oui => oui_main.routes,
        Module.sos => sos_main.routes,
        Module.a11how => a11how_main.routes,
        // krotos => krotos_main.routes,
        // ww => ww_main.routes,
        // signal => signal_main.routes,
        // ojnt => ojnt_main.routes,
      };

  Widget get homeScreen => switch (this) {
        Module.oui => const oui_screens.HomeScreen(),
        Module.sos => const sos_screens.HomeScreen(),
        Module.a11how => const a11how_screens.HomeScreen(),
        // krotos => const krotos_screens.HomeScreen(),
        // ww => const ww_screens.HomeScreen(),
        // signal => const signal_screens.HomeScreen(),
        // ojnt => const ojnt_screens.HomeScreen(),
      };

  Future<EzAppCache> cache(EzCP config) async => switch (this) {
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

        // OJNT
        // Module.ojnt => ojnt_utils.A11howCache(
        //     config.locale,
        //     await ojnt_utils.Lang.delegate.load(config.locale),
        //   ),
      };
}
