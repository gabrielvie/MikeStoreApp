// Dart imports.
import 'dart:convert';

// Flutter imports.
import 'package:http/http.dart' as http;

// App imports.
import 'package:mikestore/models/cart.dart';
import 'package:mikestore/models/order.dart';
import 'package:mikestore/providers/provider.dart';

class OrdersProvider extends Provider {
  String resourceName = '/orders';

  Order _order;

  List<Order> _items = [];

  List<Order> get items => _items;

  Future<void> addOrder(Cart cart) async {
    // Create Order object.
    _order = new Order(
      amount: cart.amount,
      items: cart.items,
      dateTime: DateTime.now(),
    );

    try {
      // Call create method to send order to API.
      await create();

      // Insert Order object at the beginning of List<Order>.
      _items.insert(0, _order);

      // Cleanup current _order variable
      _order = null;
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }

  @override
  Future<void> create() async {
    String apiUrl = getApiUrl();
    final response = await http.post(apiUrl, body: _order.toJson());
    final decodedResponse = json.decode(response.body);

    // Assign response id to Order object;
    _order.id = decodedResponse['name'];
  }

  @override
  Future<void> delete() {
    throw UnimplementedError();
  }

  @override
  Future<void> fetchData() {
    // TODO: implement fetchData
    throw UnimplementedError();
  }

  @override
  Future<void> update() {
    throw UnimplementedError();
  }
}
