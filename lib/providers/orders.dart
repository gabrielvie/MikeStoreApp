import 'package:flutter/foundation.dart';

import 'package:mikestore/providers/cart.dart';

class OrderItem {
  final String uuid;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.uuid,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class OrdersProvider extends ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items => _items;

  void addOrder(List<CartItem> cartItems, double total) {
    _items.insert(
        0,
        OrderItem(
          uuid: DateTime.now().toString(),
          amount: total,
          products: cartItems,
          dateTime: DateTime.now(),
        ));

    notifyListeners();
  }
}
