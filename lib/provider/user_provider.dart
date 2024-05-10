import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kuis_statemanagement/models/user.dart';

class UserProvider with ChangeNotifier {
  int? _userId;
  User? _user;

  int? get userId => _userId;
  User? get user => _user;

  Future<void> fetchUser() async {
    final response = await http.get(Uri.parse('http://0.0.0.0:8000/users/${_userId}'));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      _user = User.fromJson(responseBody);
      notifyListeners();
    } else {
      // Handle error
    }
  }
}