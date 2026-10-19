/* coi_pond
 * Copyright (c) 2026 YWT. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:a11how/main.dart' as a11how_main;
import 'package:a11how/screens/export.dart' as a11how_screens;
import 'package:a11how/utils/export.dart' as a11how_utils;

import 'package:sos/main.dart' as sos_main;
import 'package:sos/screens/export.dart' as sos_screens;
import 'package:sos/utils/export.dart' as sos_utils;

import 'package:open_ui/open_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// COI POND
const String appName = 'COI POND';

/// llc.ywt.coi_pond
const String androidPackage = 'llc.ywt.coi_pond';

enum Module { a11how, sos }

extension ModCon on Module {
  Set<TargetPlatform> get platforms => switch (this) {
        // a11how - not fuchsia
        Module.a11how => <TargetPlatform>{
            TargetPlatform.android,
            TargetPlatform.iOS,
            TargetPlatform.linux,
            TargetPlatform.macOS,
            TargetPlatform.windows,
          },

        // sos - mobile
        Module.sos => <TargetPlatform>{
            TargetPlatform.android,
            TargetPlatform.iOS,
          },
      };

  IconData get icon => switch (this) {
        Module.a11how => Icons.translate,
        Module.sos => Icons.notifications_active,
      };

  String get path => switch (this) {
        Module.a11how => 'a11how',
        Module.sos => 'sos',
      };

  String get name => switch (this) {
        Module.a11how => 'a11how',
        Module.sos => 'InstaSOS',
      };

  List<RouteBase> get routes => switch (this) {
        Module.a11how => a11how_main.routes,
        Module.sos => sos_main.routes,
      };

  Widget get homeScreen => switch (this) {
        Module.a11how => const a11how_screens.HomeScreen(),
        Module.sos => const sos_screens.HomeScreen(),
      };

  Future<EzAppCache> cache(EzCP config) async => switch (this) {
        // a11how
        Module.a11how => a11how_utils.A11howCache(
            config.locale,
            await a11how_utils.Lang.delegate.load(config.locale),
          ),

        // sos
        Module.sos => sos_utils.SOSCache(
            config.locale,
            await sos_utils.Lang.delegate.load(config.locale),
          ),
      };
}
