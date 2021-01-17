import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
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

  void toogleFavoriteStatus() {
    isDesired = !isDesired;
    notifyListeners();
  }
}
