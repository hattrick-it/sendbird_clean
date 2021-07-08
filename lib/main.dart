import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Core/routes.dart';

import 'l10n/l10n.dart';
import 'locator/locator.dart';
import 'presentation/screens/user_type_selector_screen/user_type_selector_screen.dart';
import 'presentation/viewmodel/auth_viewmodel/auth_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    adminConnect(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: UserSelectorScreen.routeName,
      routes: MyRoutes().routes,
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

void adminConnect(BuildContext context) async {
  await context.read(authNotifierProvider).connect(
        'admin',
        'admin',
      );
}
