import 'package:flutter/foundation.dart';

import 'package:mikestore/models/cart.dart';
import 'package:mikestore/models/product.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _items = {};

  Map<String, Cart> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0;
    _items.forEach((key, cart) {
      total += cart.price * cart.quantity;
    });

    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (cart) => Cart(
          id: cart.id,
          title: cart.title,
          quantity: cart.quantity + 1,
          price: cart.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => Cart(
          id: DateTime.now().toString(),
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
        (cart) => Cart(
          id: cart.id,
          title: cart.title,
          quantity: cart.quantity - 1,
          price: cart.price,
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
