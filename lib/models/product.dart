// Dart imports.
import 'dart:convert';

// Flutter imports.
import 'package:flutter/foundation.dart';

// TODO: remove this change notifier.
class Product with ChangeNotifier {
  String id;
  String title;
  String imageUrl;
  String description;
  String creatorId;
  double price;
  bool isDesired;

  Product({
    this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.description,
    @required this.creatorId,
    @required this.price,
    this.isDesired = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'creatorId': creatorId,
      'price': price,
      'isDesired': isDesired,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Product(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      description: map['description'],
      creatorId: map['creatorId'],
      price: map['price'],
      isDesired: map['isDesired'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Product(id: $id, title: $title, imageUrl: $imageUrl, description: $description, creatorId: $creatorId, price: $price, isDesired: $isDesired)';
  }
}
