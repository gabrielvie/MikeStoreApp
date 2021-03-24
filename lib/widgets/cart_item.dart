// Flutter imports.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// App imports.
import 'package:mikestore/models/product.dart';
import 'package:mikestore/providers/cart.dart';
import 'package:mikestore/providers/products.dart';

class CartItem extends StatelessWidget {
  final String productId;
  final double price;
  final int quantity;

  const CartItem({
    Key key,
    this.productId,
    this.price,
    this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductsProvider productsProvider = Provider.of(context, listen: false);
    Product product = productsProvider.find(productId);

    return Dismissible(
      key: ValueKey(productId),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(right: 15, top: 5, bottom: 5),
        padding: const EdgeInsets.only(right: 10),
        alignment: AlignmentDirectional.centerEnd,
        decoration: BoxDecoration(
          color: Theme.of(context).errorColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (_) async {
        Provider.of<CartProvider>(context).removeItem(productId);
      },
      confirmDismiss: (_) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are you sure?'),
          content:
              Text('Do you want to remove ${product.title} from the cart?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
            title: Text("${product.title}"),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
