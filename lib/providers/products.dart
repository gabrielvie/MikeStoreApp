// Dart imports.
import 'dart:convert';

// Flutter imports.
import 'package:http/http.dart' as http;

// App imports.
import 'package:mikestore/models/product.dart';
import 'package:mikestore/models/user.dart';
import 'package:mikestore/providers/provider.dart';
import 'package:mikestore/utils/exeptions.dart';

class ProductsProvider extends Provider {
  String resourceName = '/products';

  List<Product> _items = [];

  Product _product;

  Future<void> fetch([bool filterByUser = false]) async {
    String url = getApiUrl();

    if (filterByUser) {
      url += '&orderBy="creatorId"&equalTo="${user.id}"';
    }

    final response = await http.get(url);
    final responseData = json.decode(response.body) as Map<String, dynamic>;
    final List<Product> products = [];

    if (response.statusCode >= 400) {
      throw new HttpException(
        code: response.statusCode,
        error: responseData['error'],
      );
    }

    responseData.forEach((id, data) {
      data['id'] = id;
      products.add(Product.fromMap(data));
    });

    _items = products;
    notifyListeners();
  }

  Future<void> create(Product product) async {
    _product = product;

    try {
      String url = getApiUrl();

      final response = await http.post(url, body: _product.toJson());
      final decodedResponseBody = json.decode(response.body);

      // Assign response id to Product object.
      _product.id = decodedResponseBody['name'];

      // Add product objetc at the end of List<Product>.
      _items.add(_product);

      // Cleanup current _product.
      _product = null;
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }

  Future<void> update(Product product) async {
    try {
      _product = product;

      String url = getApiUrl('/${_product.id}');
      // TODO: Add an custom exception trait.
      await http.patch(url, body: _product.toJson());

      // Cleanup current _product.
      _product = null;
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }

  Future<void> delete(Product product) async {
    try {
      _product = product;

      String url = getApiUrl('/${_product.id}');

      final response = await http.delete(url);

      if (response.statusCode >= 400) {
        throw new Exception(response);
      }

      // Remove product from List<Product>.
      _items.remove(_product);

      // Cleanup current _product.
      _product = null;
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }

  Product find(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  List<Product> get items => _items;

  List<Product> get desiredItems =>
      _items.where((product) => product.isDesired).toList();
}
