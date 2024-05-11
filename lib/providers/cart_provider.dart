import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kuis_statemanagement/models/cart_item.dart';
import 'package:kuis_statemanagement/providers/item_quantity_notifier.dart';
import 'package:provider/provider.dart';
import 'package:kuis_statemanagement/models/item.dart';
import 'package:http/http.dart' as http;
import 'package:kuis_statemanagement/globals.dart';


class CartProvider with ChangeNotifier {
  // List<Item> _items = [];
  // List<Item> _selectedItems = [];

  final ItemQuantityNotifier itemQuantityNotifier;
  List<CartItem> _cart_items = [];

  CartProvider({required this.itemQuantityNotifier});


  // Getter for items
  // List<Item> get items => _selectedItems;

  // List<Item> get selectedItems => _selectedItems;

  // Future<void> fetchItems(String? token) async {
  //   final response = await http.get(
  //     Uri.parse(api_url + '/items?skip=0&limit=10'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization':'Bearer $token'
  //     },
  //     );
  //   if (response.statusCode == 200) {
  //     _items = (jsonDecode(response.body) as List)
  //         .map((item) => Item.fromJson(item))
  //         .toList();
  //     print("items success");
  //     _items.forEach((element) => print(element.title),);
  //     notifyListeners();
  //   } else {
  //     throw Exception('Failed to load items');
  //   }
  // }

  Future<void> postItemToCart(int item_id, int quantity, int userId, String? token) async {
    try {
      final response = await http.post(Uri.parse("$api_url/carts/$userId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          'item_id': item_id,  // key from map
          'quantity': quantity, // value from map
          'user_id': userId,
        })

      );
      print(jsonDecode(response.body));
      if(response.statusCode == 200) {


         CartItem? cartItem;
         cartItem = CartItem.fromJson(jsonDecode(response.body));
         print(cartItem);
        _cart_items.add(cartItem);

        notifyListeners();

      } else {
        throw Exception("Failed to post cart");
      }
    } catch (e) {
      // TODO
      print("Error ${e.toString()}");
    }
  }

  Future<void> postAllItemsToCart(int userId, String? token) async {
    Map<int, int> quantities = itemQuantityNotifier.getAllItemQuantities();
    try {
      // Iterate through the map
      for (var entry in quantities.entries) {
        print("posting... item_id: ${entry.key}, quantity: ${entry.value}");
        await postItemToCart(entry.key, entry.value, userId, token);
      }
    } catch (e) {
      print("Error ${e.toString()}");
      // Handle error here if needed
    }
  }

  // void addItemToSelected(Item item) {


  //   if (!_selectedItems.contains(item)) {
  //     _selectedItems.add(item);
  //   }
  //   notifyListeners(); // Notify listeners of change
  // }



  // // Method to remove item from selected items
  // void removeItemFromSelected(Item item) {


  //   if (_selectedItems.contains(item)) {
  //     _selectedItems.remove(item);
  //   }

  //   notifyListeners(); // Notify listeners of change
  // }
}