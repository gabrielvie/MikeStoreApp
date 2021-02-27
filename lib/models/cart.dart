// Dart imports.
import 'dart:convert';

// App imports.
import 'package:mikestore/models/cart_item.dart';

class Cart {
  String id;
  List<CartItem> cartItems;

  Cart({
    this.id,
    this.cartItems,
  });

  Cart copyWith({
    String id,
    List<CartItem> cartItems,
  }) {
    return Cart(
      id: id ?? this.id,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cartItems': cartItems?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Cart(
      id: map['id'],
      cartItems: List<CartItem>.from(
          map['cartItems']?.map((x) => CartItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() => 'Cart(id: $id, cartItems: $cartItems)';
}
