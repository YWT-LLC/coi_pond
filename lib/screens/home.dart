/* coi_pond
 * Copyright (c) 2026 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../screens/export.dart';
import '../utils/export.dart';
import '../widgets/export.dart';

import 'package:open_ui/open_ui.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define the build data //

  late final TargetPlatform curr = getBasePlatform();

  // Set the page title //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(appName);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Consumer<EzProvider>(
      builder: (_, EzProvider config, __) => CoiPondScaffold(
        config,
        body: EzScreen(
          config,
          child: Center(
            child: EzCol(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: Module.values
                  .where((Module module) => module.platforms.contains(curr))
                  .map((Module module) => Padding(
                        padding: EzInsets.col(config.spacing),
                        child: EzTextIconButton(
                          config,
                          label: module.name,
                          icon: EzIcon(config, module.icon),
                          onPressed: () async {
                            config.swapCache(await module.cache(config));
                            if (context.mounted) context.goNamed(module.name);
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        fabs: <Widget>[
          FloatingActionButton(
            heroTag: 'settingsFAB',
            onPressed: () => context.goNamed(settingsScreenName),
            child: EzIcon(config, Icons.settings),
          ),
        ],
        isHome: true,
      ),
    );
  }
}
