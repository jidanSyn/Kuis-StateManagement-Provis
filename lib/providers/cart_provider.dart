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

  Future<void> fetchUserCart(int? user_id, String? token) async {
    try {
      final response = await http.get(Uri.parse("$api_url/carts/$user_id"),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if(response.statusCode == 200) {

        _cart_items = (jsonDecode(response.body) as List)
              .map((e) => CartItem.fromJson(e))
              .toList();

        for(var cart_item in _cart_items) {
          itemQuantityNotifier.addItem(cart_item.item_id, cart_item.quantity);
        }

      } else {
        throw Exception(jsonDecode(response.body) ?? "Failed to fetch Carts");
      }

    } catch (e) {
      print("Error ${e.toString()}");
    }
  }

  Future<void> postItemToCart(int item_id, int quantity, int userId, String? token) async {
    try {
      final response = await http.post(Uri.parse("$api_url/carts/"),
        headers: {
          'accept': 'application/json',
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
         print(cartItem.id);
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

    // penghapusan record sebelumnya item sama tapi beda kuantitas (update)
    print("quantities");
    print(quantities);
    print("cart items");
    for(var cart_item in _cart_items) {
      print("cart id ${cart_item.id}, item id ${cart_item.item_id}, quantity ${cart_item.quantity}");
    }


    if(quantities.isNotEmpty && _cart_items.isNotEmpty) {
      print("check duplicate but different quantity");

      for(var entry in quantities.entries) {

        bool hasDifferentQuantity = _cart_items.any((element) => (element.item_id == entry.key) && (element.quantity != entry.value));

        if(hasDifferentQuantity) {

          CartItem? check = _cart_items.firstWhere((element) => (element.item_id == entry.key) && (element.quantity != entry.value));
            print("check for itemid ${entry.key}, supposed to be ${entry.value}; data has ${check.quantity}");
            if(check.quantity != entry.value) {
              print("different quantities, will delete cart id ${check.id}");
              deleteItemById(check.id, userId, token, true);
            }

        }

      }

    }

    // for(var item in _cart_items) {
    //   if(quantities.containsKey(item.item_id)) {
    //     if(quantities[item.item_id] != item.quantity) {
    //       deleteItemById(item.item_id, userId, token, true);
    //     }
    //   }
    // }

    try {
      // Iterate through the map
      for (var entry in quantities.entries) {
        print("posting... item_id: ${entry.key}, quantity: ${entry.value}");

        bool alreadyExists = _cart_items.any((element) => (element.item_id == entry.key));
        bool differentQuantity = _cart_items.any((element) => (element.item_id == entry.key) && (element.quantity != entry.value));


        if(!alreadyExists || (alreadyExists && differentQuantity)) {
          await postItemToCart(entry.key, entry.value, userId, token);
        }
      }
    } catch (e) {
      print("Error ${e.toString()}");
      // Handle error here if needed
    }
  }



  Future<void> deleteItemById(int cart_id, int userId, String? token, bool updateItem) async {


    print("current cart");
    for (var cart_item in _cart_items) {
      print("id: ${cart_item.id} quantity: ${cart_item.quantity}");
    }
    try {
      final response = await http.delete(Uri.parse("$api_url/carts/$cart_id"),
        headers: {
          'Authorization': 'Bearer $token',
        }
      );
      if(response.statusCode == 200) {
        print(jsonDecode(response.body)["record_dihapus"]);

        print("removing cart id ${_cart_items.firstWhere((element) => element.id == cart_id).id}");

        _cart_items.removeWhere((element) => element.id == cart_id);

        if(!updateItem) {
          itemQuantityNotifier.removeItem((_cart_items.firstWhere((element) => element.id == cart_id).item_id));
        }

        // print("cart after delete $item_id");
        for (var cart_item in _cart_items) {
          print("item_id: ${cart_item.item_id} quantity: ${cart_item.quantity}");
        }

      } else {
        print(jsonDecode(response.body));
        throw Exception("Failed to delete cart");
      }
      print(_cart_items);
    } catch (e) {
      print("Error ${e.toString()}");
    }

  }

  Future<void> deleteItemByItemId(int item_id, int userId, String? token, bool updateItem) async {


    try {

      print("current cart want delete $item_id");
      for (var cart_item in _cart_items) {
        print("id: ${cart_item.id}, item_id ${cart_item.item_id} quantity: ${cart_item.quantity}");
      }

      CartItem cartItem = _cart_items.firstWhere((element) => element.item_id == item_id);

      final response = await http.delete(Uri.parse("$api_url/carts/${cartItem.item_id}"),
        headers: {
          'Authorization': 'Bearer $token',
        }
      );
      if(response.statusCode == 200) {
        print(jsonDecode(response.body)["record_dihapus"]);

        print("removing cart id ${_cart_items.firstWhere((element) => element.id == cartItem).id}");

        _cart_items.removeWhere((element) => element.id == cartItem.id);

        if(!updateItem) {
          itemQuantityNotifier.removeItem((_cart_items.firstWhere((element) => element.id == cartItem.id).item_id));
        }

        // print("cart after delete $item_id");
        for (var cart_item in _cart_items) {
          print("item_id: ${cart_item.item_id} quantity: ${cart_item.quantity}");
        }

      } else {
        print("json failed?");
        print(jsonDecode(response.body));
        throw Exception("Failed to delete cart");
      }
      print(_cart_items);
    } catch (e) {
      print("Error ${e.toString()}");
    }

  }

  Future deleteAllItemCart(int userId, String? token) async {
    print("current cart");
    for (var cart_item in _cart_items) {
      print("id: ${cart_item.id} quantity: ${cart_item.quantity}");
    }
    try {
      final response = await http.delete(Uri.parse("$api_url/clear_whole_carts_by_userid/$userId"),
        headers: {
          'Authorization': 'Bearer $token',
        }
      );
      if(response.statusCode == 200) {
        print(jsonDecode(response.body)["record_dihapus"]);

        _cart_items.clear();
        itemQuantityNotifier.removeAllQuantities();

        print("cart after delete ");
        for (var cart_item in _cart_items) {
          print("item_id: ${cart_item.item_id} quantity: ${cart_item.quantity}");
        }

      } else {
        print(jsonDecode(response.body));
        throw Exception("Failed to delete cart");
      }
      print(_cart_items);
    } catch (e) {
      print("Error ${e.toString()}");
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