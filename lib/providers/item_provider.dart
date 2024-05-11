import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kuis_statemanagement/models/item.dart';
import 'package:http/http.dart' as http;
import 'package:kuis_statemanagement/globals.dart';


class ItemProvider with ChangeNotifier {
  List<Item> _items = [];
  List<Item> _selectedItems = [];

  // Getter for items
  List<Item> get items => _items;
  // List<Item> get selectedItems => _selectedItems;

  Future<void> fetchItems(String? token) async {
    final response = await http.get(
      Uri.parse(api_url + '/items?skip=0&limit=10'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':'Bearer $token'
      },
      );
    if (response.statusCode == 200) {
      _items = (jsonDecode(response.body) as List)
          .map((item) => Item.fromJson(item))
          .toList();
      print("items success");
      _items.forEach((element) => print(element.title),);
      notifyListeners();
    } else {
      throw Exception('Failed to load items');
    }
  }


}