// Dart imports.
import 'dart:convert';

// Flutter imports.
import 'package:flutter/foundation.dart';

// App imports.
import 'package:mikestore/models/cart_item.dart';

class Order {
  String id;
  String ownerId;
  double amount;
  List<CartItem> items;
  DateTime dateTime;

  Order({
    this.id,
    @required this.ownerId,
    @required this.amount,
    @required this.items,
    @required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerId': ownerId,
      'amount': amount,
      'items': items?.map((x) => x?.toMap())?.toList(),
      'dateTime': dateTime?.millisecondsSinceEpoch,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Order(
      id: map['id'],
      ownerId: map['ownerId'],
      amount: map['amount'],
      items: List<CartItem>.from(map['items']?.map((x) => CartItem.fromMap(x))),
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(id: $id, ownerId: $ownerId, amount: $amount, items: $items, dateTime: $dateTime)';
  }
}
