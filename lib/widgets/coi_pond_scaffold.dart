/* coi_pond
 * Copyright (c) 2026 YWT. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

import 'package:open_ui/open_ui.dart';
import 'package:flutter/material.dart';

class CoiPondScaffold extends StatelessWidget {
  final EzCP config;
  final String title;
  final bool showSettings;
  final Widget body;
  final List<Widget>? fabs;
  final bool isHome;

  const CoiPondScaffold(
    this.config, {
    super.key,
    this.title = appName,
    this.showSettings = true,
    required this.body,
    this.fabs,
    this.isHome = false,
  });

  @override
  Widget build(BuildContext context) => EzAdaptiveParent(
        small: EzScaffold(
          config,
          body: body,
          fabs: <Widget>[
            if (fabs != null) ...fabs!,
            ...config.backFABs(isHome: isHome),
          ],
        ),
      );
}
