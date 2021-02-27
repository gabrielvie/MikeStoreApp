// Flutter imports.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// App imports.
import 'package:mikestore/providers/cart.dart' show CartProvider;
import 'package:mikestore/widgets/app_drawer.dart';
import 'package:mikestore/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      "\$${cartProvider.cart.amount.toStringAsFixed(2)}",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  FlatButton(
                    onPressed: () async {
                      // TODO: Fix this call.
                      // Provider.of<OrdersProvider>(context, listen: false)
                      //     .addOrder(
                      //   cartProvider.items.values.toList(),
                      //   cartProvider.totalAmount,
                      // );
                      cartProvider.clear();
                    },
                    child: const Text("Order Now"),
                    textColor: Theme.of(context).primaryColorDark,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, index) => CartItem(
                productId: cartItems[index].productId,
                price: cartItems[index].price,
                quantity: cartItems[index].quantity,
              ),
              itemCount: cartProvider.itemCount,
            ),
          )
        ],
      ),
    );
  }
}
