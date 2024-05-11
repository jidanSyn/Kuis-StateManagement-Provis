import 'dart:convert';
import 'dart:typed_data';

class CartItem {
  final int id;
  final int item_id;
  final int user_id;
  int quantity;

  CartItem({required this.id, required this.item_id, required this.user_id, this.quantity = 0});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        id: json['id'],
        item_id: json['item_id'],
        user_id: json['user_id'],
        quantity: json['quantity'],
      );
  }



}

