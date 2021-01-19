import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopapp/providers/cart.dart' show CartProvider;
import 'package:shopapp/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
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
                      "\$${cartProvider.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  FlatButton(
                    onPressed: () => print("ordering"),
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
              uuid: cartProvider.items.values.toList()[index].uuid,
              title: cartProvider.items.values.toList()[index].title,
              price: cartProvider.items.values.toList()[index].price,
              quantity: cartProvider.items.values.toList()[index].quantity,
              productUuid: cartProvider.items.keys.toList()[index],
            ),
            itemCount: cartProvider.itemCount,
          ))
        ],
      ),
    );
  }
}
