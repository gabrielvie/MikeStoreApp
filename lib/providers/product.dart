import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  String uuid;
  String title;
  String imageUrl;
  String description;
  double price;
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
