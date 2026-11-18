/* coi_pond
 * Copyright (c) 2026 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';
import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:open_ui/open_ui.dart';
import 'package:material_ui/material_ui.dart';

class CoiPondScaffold extends StatelessWidget {
  final EzCP config;
  final String title;
  final bool showSettings;
  final Widget body;
  final List<Widget>? fabs;
  final bool isHome;
  final bool settingsA11;

  const CoiPondScaffold(
    this.config, {
    super.key,
    this.title = appName,
    this.showSettings = true,
    required this.body,
    this.fabs,
    this.isHome = false,
    this.settingsA11 = true,
  });

  @override
  Widget build(BuildContext context) => EzAdaptiveParent(
        small: EzScaffold(
          config,
          body: body,
          footer: EzFooter(
            config,
            quiet: isHome,
            a11howPath: settingsA11 ? ywt.openUIContributeA11 : ywt.coiPondContributeA11,
          ),
          fabs: <Widget>[
            EzUpdaterFAB(
              config,
              appVersion: '1.0.1',
              versionSource:
                  'https://raw.githubusercontent.com/YWT-LLC/coi_pond/refs/heads/main/APP_VERSION',
              gPlay: ywt.coiPondGPlay,
              appStore: ywt.coiPondAppStore,
              github: ywt.coiPondReleases,
            ),
            if (fabs != null) ...fabs!,
            ...config.backFABs(isHome: isHome),
          ],
        ),
      );
}
