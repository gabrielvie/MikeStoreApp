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

  Future<void> fetch() async {
    String url = getApiUrl();
    url += '&orderBy="ownerId"&equalTo="${user.id}"';

    final response = await http.get(url);
    final responseData = json.decode(response.body) as Map<String, dynamic>;

    // If response comes from API Servers, was an empty list, returns void.
    if (responseData == null) return;

    // Reset the _items list.
    _items = [];
    responseData.forEach((key, data) {
      data['id'] = key;
      _items.insert(0, Order.fromMap(data));
    });

    notifyListeners();
  }

  Future<void> create() async {
    String url = getApiUrl();
    final response = await http.post(url, body: _order.toJson());
    final decodedResponse = json.decode(response.body);

    // Assign response id to Order object.
    _order.id = decodedResponse['name'];
  }

  List<Order> get items => _items;

  Future<void> addOrder(Cart cart) async {
    // Create Order object.
    _order = new Order(
      ownerId: user.id,
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
}
