// Dart imports.
import 'dart:convert';

// Flutter imports.
import 'package:http/http.dart' as http;

// App imports.
import 'package:mikestore/models/cart.dart';
import 'package:mikestore/models/cart_item.dart';
import 'package:mikestore/models/product.dart';
import 'package:mikestore/providers/provider.dart';

class CartProvider extends Provider {
  String resourceName = '/carts';
  Cart _cart;

  @override
  Future<void> fetch() async {
    String apiUrl = getApiUrl();

    try {
      final response = await http.get(apiUrl);
      final responseData = json.decode(response.body) as Map<String, dynamic>;

      if (responseData != null) {
        responseData.forEach((key, data) {
          data['id'] = key;
          _cart = new Cart.fromMap(data);
        });
      }
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }

  @override
  Future<void> update() async {
    String apiUrl = getApiUrl('/${_cart.id}');
    // TODO: Add an custom exception trait.
    await http.patch(apiUrl, body: _cart.toJson());
  }

  @override
  Future<void> create() async {
    String apiUrl = getApiUrl();
    final response = await http.post(apiUrl, body: _cart.toJson());
    final decodedResponse = json.decode(response.body);

    _cart.id = decodedResponse['name'];
  }

  @override
  Future<void> delete() async {
    String apiUrl = getApiUrl('/${_cart.id}');
    // TODO: Add an custom exception trait.
    await http.delete(apiUrl);
  }

  Cart get cart => _cart;

  List<CartItem> get items => _cart.items;

  int get itemCount => _cart == null ? 0 : _cart.items.length;

  Future<void> addItem(Product product) async {
    if (_cart == null) {
      _cart = Cart(items: []);
    }

    CartItem cartItem = _cart.items.firstWhere(
      (cartItem) => cartItem.productId == product.id,
      orElse: () => new CartItem(
        productId: product.id,
        quantity: 1,
        price: product.price,
      ),
    );

    // This if means that the cartItem isn't new.
    // And if is a new they will added at the end of the list.
    if (_cart.items.contains(cartItem)) {
      cartItem.quantity += 1;
    } else {
      _cart.items.add(cartItem);
    }

    try {
      // If cart doens't exists yet, create it.
      if (_cart.id == null) {
        await create();
      } else {
        await update();
      }
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }

  Future<void> clear() async {
    await delete();

    // Cleanup state _cart.
    _cart = null;

    notifyListeners();
  }

  Future<void> removeItem(String productId) async {
    _cart.items.removeWhere((cartItem) => cartItem.productId == productId);

    try {
      await update();
    } catch (error) {
      throw error;
    }
    // _item.remove(productUuid);
    notifyListeners();
  }

  void removeSingleItem(String productUuid) {
    // if (!_item.containsKey(productUuid)) {
    //   return;
    // }

    // if (_itemsLegacy[productUuid].quantity > 1) {
    //   _itemsLegacy.update(
    //     productUuid,
    //     (cart) => CartItem(
    //       id: cart.id,
    //       title: cart.title,
    //       quantity: cart.quantity - 1,
    //       price: cart.price,
    //     ),
    //   );
    //   notifyListeners();
    //   return;
    // }

    removeItem(productUuid);
  }
}
