import 'package:flutter/foundation.dart';

import 'package:shopapp/providers/product.dart';

class CartItem {
  final String uuid;
  final String title;
  final int quantity;
  final double price;

  CartItem(
    this.uuid, {
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.uuid)) {
      _items.update(
        product.uuid,
        (cartItem) => CartItem(
          cartItem.uuid,
          title: cartItem.title,
          quantity: cartItem.quantity + 1,
          price: cartItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.uuid,
        () => CartItem(
          DateTime.now().toString(),
          title: product.title,
          quantity: 1,
          price: product.price,
        ),
      );
    }

    notifyListeners();
  }
}
