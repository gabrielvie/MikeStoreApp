import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:mikestore/models/product.dart';

class ProductsProvider extends ChangeNotifier {
  static const _baseServerUrl =
      'https://shopapp-gabrielvie-default-rtdb.firebaseio.com';

  List<Product> _items = [];

  // bool _showDesiredOnly = false;
  Future<void> fetchAndSetProducts() async {
    const serverUrl = _baseServerUrl + '/products.json';

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
    const serverUrl = _baseServerUrl + '/products.json';

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

  Future<void> updateProduct(Product productToUpdate) async {
    final index =
        _items.indexWhere((product) => productToUpdate.id == product.id);

    if (index >= 0) {
      try {
        final serverUrl =
            _baseServerUrl + '/products/${productToUpdate.id}.json';

        productToUpdate.id = null;
        await http.patch(serverUrl, body: productToUpdate.toJson());
        _items[index] = productToUpdate;
      } catch (error) {
        throw error;
      }
    }

    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final productListIndex = _items.indexWhere((product) => product.id == id);
    final product = _items[productListIndex];

    // 1. Removing product from the list.
    _items.removeAt(productListIndex);
    notifyListeners();

    // 2. Send a request DELETE to server.
    final serverUrl = _baseServerUrl + '/products/$id.json';
    final response = await http.delete(serverUrl);

    // 3. If server retrives any erro greater or equal to 400, rollback the process.
    if (response.statusCode >= 400) {
      _items.insert(productListIndex, product);
      notifyListeners();

      // TODO: Make an Exception class.
      print('Could\'t delete the product $id');
      return;
    }
  }
}
