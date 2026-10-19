/* coi_pond
 * Copyright (c) 2026 YWT. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../screens/export.dart';
import '../utils/export.dart';
import '../widgets/export.dart';

import 'package:open_ui/open_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define the build data //

  // Set the page title //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(appName);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Consumer<EzCP>(
      builder: (_, EzCP config, __) => CoiPondScaffold(
        config,
        body: EzScreen(
          config,
          child: Center(
            child: EzCol(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: Module.values
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

// class _ThirdParty extends StatefulWidget {
//   final EzCP config;

//   const _ThirdParty(this.config);

//   @override
//   State<_ThirdParty> createState() => _ThirdPartyState();
// }

// class _ThirdPartyState extends State<_ThirdParty> {
//   // Define the build data //

//   final TextEditingController emailCon = TextEditingController();
//   final TextEditingController paswdCon = TextEditingController();

//   bool showPwd = false;

//   // Define custom functions //

//   String? _noEmpty(String? toCheck) =>
//       (toCheck == null || toCheck.isEmpty) ? 'Cannot be empty' : null;

//   String? _validateEmail(String? toCheck) =>
//       _noEmpty(toCheck) ?? (EmailValidator.validate(toCheck!) ? null : 'Invalid email');

//   // Return the build //

//   Widget wrapIt(Widget child) =>
//       Padding(padding: EzInsets.wrap(widget.config.spacing), child: child);

//   @override
//   Widget build(BuildContext context) => EzScrollView(widget.config, children: <Widget>[
//         AutofillGroup(
//           child: EzCol(children: <Widget>[
//             // Email field
//             EzTextField(
//               constraints: ezTextFieldConstraints(context),
//               controller: emailCon,
//               textAlign: TextAlign.start,
//               hintText: 'Enter email',
//               autofillHints: const <String>[AutofillHints.email],
//               validator: _validateEmail,
//             ),
//             widget.config.spacer,

//             // Password field
//             EzTextField(
//               constraints: ezTextFieldConstraints(context),
//               controller: paswdCon,
//               obscureText: !showPwd,
//               textAlign: TextAlign.start,
//               hintText: 'Enter password',
//               autofillHints: const <String>[AutofillHints.password],
//               suffixIcon: EzIconTouch(
//                 widget.config,
//                 icon: showPwd ? Icons.visibility : Icons.visibility_off,
//                 tooltip: showPwd ? 'Hide password' : 'Show password',
//                 onPressed: () => setState(() => showPwd = !showPwd),
//               ),
//               validator: (_) => null,
//               onFieldSubmitted: (String pwd) async {
//                 final String? error = 'nyi'; // await login(
//                 //   appUser: Provider.of<UserProvider>(context, listen: false),
//                 //   email: emailCon.text,
//                 //   password: pwd,
//                 // );

//                 if (context.mounted && error != null && error.isNotEmpty) {
//                   ezLogAlert(widget.config, context: context, message: error);
//                 }
//               },
//             ),
//           ]),
//         ),
//         widget.config.separator,

//         // Buttons
//         EzRowCol.sym(widget.config, children: <Widget>[
//           // Login
//           EzElevatedIconButton(
//             widget.config,
//             onPressed: () async {
//               closeKeyboard(context);
//               if (_validateEmail(emailCon.text) != null) {
//                 ezLogAlert(widget.config, context: context, message: 'Invalid email!');
//                 return;
//               }

//               final String? error = 'nyi'; // await login(
//               //   appUser: Provider.of<UserProvider>(context, listen: false),
//               //   email: emailCon.text,
//               //   password: paswdCon.text,
//               // );
//               if (context.mounted && error != null && error.isNotEmpty) {
//                 ezLogAlert(widget.config, context: context, message: error);
//               }
//             },
//             icon: const Icon(Icons.login),
//             label: 'Login',
//           ),
//           widget.config.swapSpacer,

//           // Sign up
//           EzElevatedIconButton(
//             widget.config,
//             onPressed: () async {
//               closeKeyboard(context);
//               if (_validateEmail(emailCon.text) != null) {
//                 ezLogAlert(widget.config, context: context, message: 'Invalid email!');
//                 return;
//               }

//               final String? error = 'nyi'; // await signUp(
//               //   appUser: Provider.of<UserProvider>(context, listen: false),
//               //   email: emailCon.text,
//               //   password: paswdCon.text,
//               // );
//               if (context.mounted && error != null && error.isNotEmpty) {
//                 ezLogAlert(widget.config, context: context, message: error);
//               }
//             },
//             icon: const Icon(Icons.edit_note_rounded),
//             label: 'Sign up',
//           ),
//         ]),
//         widget.config.separator,
//       ]);
// }
