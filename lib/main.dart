import 'package:flutter/material.dart';
import 'package:kuis_statemanagement/pages/home_page.dart';
import 'package:kuis_statemanagement/pages/keranjang_page.dart';
import 'package:kuis_statemanagement/pages/login_page.dart';
import 'package:kuis_statemanagement/providers/item_provider.dart';
import 'package:kuis_statemanagement/providers/item_quantity_notifier.dart';
import 'package:kuis_statemanagement/providers/login_provider.dart';
import 'package:kuis_statemanagement/providers/status_provider.dart';
import 'package:provider/provider.dart';
import 'package:kuis_statemanagement/providers/auth_provider.dart';
import 'package:kuis_statemanagement/providers/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ItemProvider()),
        ChangeNotifierProvider(create: (_) => ItemQuantityNotifier()),
        ChangeNotifierProvider(create: (_) => StatusProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      home: LoginPage(),
    );
  }
}
