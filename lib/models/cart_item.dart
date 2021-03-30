// Dart imports.
import 'dart:convert';

// App import.
import 'package:flutter/foundation.dart';

class CartItem {
  String productId;
  int quantity;
  double price;

  CartItem({
    @required this.productId,
    @required this.quantity,
    @required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'price': price,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CartItem(
      productId: map['productId'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CartItem(productId: $productId, quantity: $quantity, price: $price)';
  }
}
