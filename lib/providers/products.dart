import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:shopapp/providers/product.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
  ];

  // bool _showDesiredOnly = false;

  List<Product> get items {
    const serverUrl =
        'https://shopapp-gabrielvie-default-rtdb.firebaseio.com/products.json';

    http.get(serverUrl).then((response) {
      print(response.body);
    });

    return _items;
  }

  List<Product> get desiredItems =>
      _items.where((product) => product.isDesired).toList();

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  void addProduct(Product product) {
    const serverUrl =
        'https://shopapp-gabrielvie-default-rtdb.firebaseio.com/products.json';

    http.post(serverUrl, body: product.toJson()).then((response) {
      var decodedBody = json.decode(response.body);

      product.id = decodedBody['name'];
      _items.add(product);
      print(product);
      notifyListeners();
    });
  }

  void updateProduct(Product productToUpdate) {
    final index =
        _items.indexWhere((product) => productToUpdate.id == product.id);

    if (index >= 0) {
      _items[index] = productToUpdate;
    }

    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
