import 'package:flutter/foundation.dart';

class Product {
  final String uuid;
  final String title;
  final String imageUrl;
  final String description;
  final double price;
  bool isDesired;

  Product(
    this.uuid, {
    @required this.title,
    @required this.imageUrl,
    @required this.description,
    @required this.price,
    this.isDesired = false,
  });
}
