// Dart imports.
import 'dart:convert';

// Flutter imports.
import 'package:http/http.dart' as http;

// App imports.
import 'package:mikestore/models/product.dart';
import 'package:mikestore/providers/provider.dart';

class ProductsProvider extends Provider {
  String resourceName = '/products';

  List<Product> _items = [];

  Product _product;

  Future<void> fetch() async {
    String url = getApiUrl();

    try {
      final response = await http.get(url);
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

  Future<void> create() async {
    String url = getApiUrl();

    final response = await http.post(url, body: _product.toJson());
    final decodedResponseBody = json.decode(response.body);

    // Assign response id to Product object.
    _product.id = decodedResponseBody['name'];
  }

  Future<void> update() async {
    String url = getApiUrl('/${_product.id}');
    // TODO: Add an custom exception trait.
    await http.patch(url, body: _product.toJson());
  }

  Future<void> delete() async {
    String url = getApiUrl('/${_product.id}');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      throw new Exception(response);
    }
  }

  List<Product> get items => _items;

  List<Product> get desiredItems =>
      _items.where((product) => product.isDesired).toList();

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> addProduct(Product product) async {
    _product = product;

    try {
      // Call create method to send product to API.
      await create();

      // Add product objetc at the end of List<Product>.
      _items.add(_product);

      // Cleanup current _product.
      _product = null;
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    try {
      _product = product;

      // Call update method to send product to API.
      update();

      // Cleanup current _product.
      _product = null;
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }

  Future<void> deleteProduct(Product product) async {
    try {
      _product = product;

      // Call update method to send product to API.
      delete();

      // Remove product from List<Product>.
      _items.remove(_product);

      // Cleanup current _product.
      _product = null;
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }
}
