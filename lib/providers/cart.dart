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
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (cartItem) => CartItem(
          cartItem.uuid,
          title: cartItem.title,
          quantity: cartItem.quantity + 1,
          price: cartItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
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

  void removeItem(String productUuid) {
    _items.remove(productUuid);
    notifyListeners();
  }

  void removeSingleItem(String productUuid) {
    if (!_items.containsKey(productUuid)) {
      return;
    }

    if (_items[productUuid].quantity > 1) {
      _items.update(
        productUuid,
        (cartItem) => CartItem(
          cartItem.uuid,
          title: cartItem.title,
          quantity: cartItem.quantity - 1,
          price: cartItem.price,
        ),
      );
      notifyListeners();
      return;
    }

    removeItem(productUuid);
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
