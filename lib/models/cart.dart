// Dart imports.
import 'dart:convert';

// App imports.
import 'package:mikestore/models/cart_item.dart';

class Cart {
  String id;
  List<CartItem> items;

  Cart({
    this.id,
    this.items,
  });

  Cart copyWith({
    String id,
    List<CartItem> cartItems,
  }) {
    return Cart(
      id: id ?? this.id,
      items: cartItems ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cartItems': items?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Cart(
      id: map['id'],
      items: List<CartItem>.from(
          map['cartItems']?.map((x) => CartItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() => 'Cart(id: $id, cartItems: $items)';

  double get amount => items.fold(0,
      (previousAmount, item) => previousAmount + (item.price * item.quantity));
}
