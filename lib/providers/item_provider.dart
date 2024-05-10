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
  List<Item> get selectedItems => _selectedItems;

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

  void addItemToSelected(Item item) {
    final existingItem = _selectedItems.firstWhere(
      (selectedItem) => selectedItem.id == item.id,
      orElse: () => Item(id: item.id, title: item.title, description: item.description, img_name: item.img_name, price: item.price),
    );

    if (existingItem.quantity < item.quantity) {
      existingItem.quantity++;
    }

    if (!_selectedItems.contains(existingItem)) {
      _selectedItems.add(existingItem);
    }
    notifyListeners(); // Notify listeners of change
  }

  // Method to remove item from selected items
  void removeItemFromSelected(Item item) {
    final existingItem = _selectedItems.firstWhere(
      (selectedItem) => selectedItem.id == item.id,
      orElse: () => Item(id: item.id, title: item.title, description: item.description, img_name: item.img_name, price: item.price),
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity--;
    }

    if (existingItem.quantity == 0) {
      _selectedItems.remove(existingItem);
    }

    notifyListeners(); // Notify listeners of change
  }
}