import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _token;
  int? _userId;


  String? get token => _token;
  int? get userId => _userId;

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://0.0.0.0:8000/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      _token = jsonDecode(response.body)['access_token'];
      _userId = jsonDecode(response.body)['user_id'];
      notifyListeners();
    } else {
      // Handle error
    }
  }

  Future<void> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('localhost:8000/users/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
      // Handle successful registration
    } else {
      // Handle error
    }
  }
}