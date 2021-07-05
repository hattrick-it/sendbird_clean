import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Core/routes.dart';

import 'locator/locator.dart';
import 'presentation/viewmodel/auth_viewmodel/auth_viewmodel.dart';

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
      title: 'Material App',
      // initialRoute: '/',
      initialRoute: '/user-type-selector',
      routes: MyRoutes().routes,
    );
  }
}

void adminConnect(BuildContext context)async{
  await context.read(authNotifierProvider).connect('admin','admin');
}