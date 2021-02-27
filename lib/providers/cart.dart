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
  Future<void> fetchData() async {
    String apiUrl = getApiUrl('.json');

    try {
      final response = await http.get(apiUrl);
      final responseData = json.decode(response.body);
      final cartData = responseData.entries.last;

      _cart = new Cart(
        id: cartData.key,
        cartItems: [],
      );

      final cartItemsData = cartData.value;
      cartItemsData['cartItems'].forEach((cartItemData) {
        _cart.cartItems.add(CartItem.fromMap(cartItemData));
      });
    } catch (error) {
      print(error.toString());
    }

    notifyListeners();
  }

  @override
  Future<void> update() async {
    String apiUrl = getApiUrl('/${_cart.id}.json');
    // TODO: Add an custom exception trait.
    await http.patch(apiUrl, body: _cart.toJson());
  }

  @override
  Future<void> create() async {
    String apiUrl = getApiUrl('.json');
    final response = await http.post(apiUrl, body: _cart.toJson());
    final decodedResponse = json.decode(response.body);

    _cart.id = decodedResponse['name'];
  }

  List<CartItem> get items => _cart.cartItems;

  int get itemCount => _cart != null ? _cart.cartItems.length : 0;

  double get totalAmount {
    double total = 0;
    _cart.cartItems.forEach((cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  Future<void> addItem(Product product) async {
    if (_cart == null) {
      _cart = Cart(cartItems: []);
    }

    CartItem cartItem = _cart.cartItems.firstWhere(
      (cartItem) => cartItem.productId == product.id,
      orElse: () => new CartItem(
        productId: product.id,
        quantity: 1,
        price: product.price,
      ),
    );

    // This if means that the cartItem isn't new.
    // And if is a new they will added at the end of the list.
    if (_cart.cartItems.contains(cartItem)) {
      cartItem.quantity += 1;
    } else {
      _cart.cartItems.add(cartItem);
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

  void removeItem(String productUuid) {
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

  void clear() {
    // _item = {};
    notifyListeners();
  }
}
