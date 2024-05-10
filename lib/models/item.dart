import 'dart:convert';
import 'dart:typed_data';

class Item {
  final int id;
  final String title;
  final int price;
  final String description;
  final String img_name;

  Item({required this.id, required this.title, required this.description, required this.img_name, required this.price});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: json['price'],
        img_name: json['img_name']
      );
  }
}

