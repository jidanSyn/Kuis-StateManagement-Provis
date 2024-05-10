import 'dart:convert';
import 'package:kuis_statemanagement/globals.dart';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _token;
  int? _userId;


  String? get token => _token;
  int? get userId => _userId;

  Future<void> login(String username, String password) async {

    print('Payload for login: ${jsonEncode({'username': username, 'password': password})}');

    final response = await http.post(
      Uri.parse(api_url + '/login'),
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
      print(_userId);
      print(_token);
      notifyListeners();
    } else {
      // Handle error
      throw Exception("User not found");
    }
  }

  Future<void> register(String username, String password) async {
    final response = await http.post(
      Uri.parse(api_url+'/users/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      // Handle successful registration
      // final test = jsonDecode(response.body)["username"];
      // print("user registered successfully");
      // print(test);
    } else {
      // Handle error
    }
  }
}