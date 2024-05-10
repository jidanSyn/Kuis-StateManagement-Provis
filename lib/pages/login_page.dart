import 'package:flutter/material.dart';
import 'package:kuis_statemanagement/pages/home_page.dart';
import 'package:kuis_statemanagement/pages/register_page.dart';
import 'package:kuis_statemanagement/providers/login_provider.dart';
import 'package:kuis_statemanagement/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:kuis_statemanagement/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              if (loginProvider.errorMessage != null) // Display error message if present
                Text(
                  loginProvider.errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState != null) {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      try {
                        // Attempt to login
                        await Provider.of<AuthProvider>(context, listen: false)
                            .login(_usernameController.text, _passwordController.text);

                        // Navigate to home page if login successful
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } catch (error) {
                        // If user not found, set error message using LoginProvider
                        loginProvider.setErrorMessage('User not found');
                      }
                    }
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 8.0),
              Text("Belum Punya Akun?"),
              SizedBox(height: 10.0),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  'Daftar disini',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}