import 'package:flutter/material.dart';
import 'package:kuis_statemanagement/pages/login_page.dart';
import 'package:kuis_statemanagement/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:kuis_statemanagement/provider/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Your App',
        home: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            if (provider.token != null) {
              return Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  if (userProvider.user != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome, ${userProvider.user!.username}',
                            style: TextStyle(fontSize: 24),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              // await provider.logout();
                            },
                            child: Text('Logout'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please login to continue',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text('Login'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}