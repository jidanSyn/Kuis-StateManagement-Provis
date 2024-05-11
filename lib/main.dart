import 'package:flutter/material.dart';
import 'package:kuis_statemanagement/pages/home_page.dart';
import 'package:kuis_statemanagement/pages/keranjang_page.dart';
import 'package:kuis_statemanagement/pages/login_page.dart';
import 'package:kuis_statemanagement/providers/cart_provider.dart';
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
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<ItemProvider>(create: (_) => ItemProvider()),
        ChangeNotifierProvider<ItemQuantityNotifier>(create: (_) => ItemQuantityNotifier()),
        ChangeNotifierProvider<StatusProvider>(create: (_) => StatusProvider()),
      ],
      child: Builder(
        builder: (context) {
          final itemQuantityNotifier = Provider.of<ItemQuantityNotifier>(context, listen: false);
          return ChangeNotifierProvider<CartProvider>(
            create: (_) => CartProvider(itemQuantityNotifier: itemQuantityNotifier),
            child: MyApp(),
          );
        },
      ),
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
