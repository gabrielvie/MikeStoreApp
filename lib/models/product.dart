// Dart imports.
import 'dart:convert';

// Flutter imports.
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  String id;
  String title;
  String imageUrl;
  String description;
  double price;
  bool isDesired;

  Product({
    this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.description,
    @required this.price,
    this.isDesired = false,
  });

  void toogleFavoriteStatus() {
    isDesired = !isDesired;
    notifyListeners();
  }

  Product copyWith({
    String id,
    String title,
    String imageUrl,
    String description,
    double price,
    bool isDesired,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      isDesired: isDesired ?? this.isDesired,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
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
      price: map['price'],
      isDesired: map['isDesired'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Product(id: $id, title: $title, imageUrl: $imageUrl, description: $description, price: $price, isDesired: $isDesired)';
  }
}
