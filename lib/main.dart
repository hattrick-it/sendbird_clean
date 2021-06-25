import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'Core/constants.dart';
import 'Core/routes.dart';

import 'locator/locator.dart';

final sendbird = SendbirdSdk(appId: Constants.api_key);

void main() {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      // initialRoute: '/',
      initialRoute: '/user-type-selector',
      routes: MyRoutes().routes,
    );
  }
}
