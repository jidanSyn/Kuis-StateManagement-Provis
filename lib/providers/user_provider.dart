import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kuis_statemanagement/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> fetchUser(int? userId, String? token) async {
    final response = await http.get(
      Uri.parse('http://146.190.109.66:8000/users/${userId}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':'Bearer $token'
      },
      );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      _user = User.fromJson(responseBody);
      print("success");
      notifyListeners();
    } else {
      // Handle error
      print("error");
    }
  }
}