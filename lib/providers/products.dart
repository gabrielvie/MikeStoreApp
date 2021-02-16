import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:mikestore/providers/product.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> _items = [];

  // bool _showDesiredOnly = false;
  Future<void> fetchAndSetProducts() async {
    const serverUrl =
        'https://shopapp-gabrielvie-default-rtdb.firebaseio.com/products.json';

    try {
      final response = await http.get(serverUrl);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> products = [];

      responseData.forEach((id, data) {
        data['id'] = id;
        products.add(Product.fromMap(data));
      });

      _items = products;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<Product> get items {
    return _items;
  }

  List<Product> get desiredItems =>
      _items.where((product) => product.isDesired).toList();

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> addProduct(Product product) async {
    const serverUrl =
        'https://shopapp-gabrielvie-default-rtdb.firebaseio.com/products.json';

    try {
      final response = await http.post(serverUrl, body: product.toJson());
      final decodedResponseBody = json.decode(response.body);

      product.id = decodedResponseBody['name'];
      _items.add(product);
    } catch (error) {
      throw error;
    }
    notifyListeners();
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
