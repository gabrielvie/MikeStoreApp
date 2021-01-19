import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String uuid;
  final double price;
  final int quantity;
  final String title;

  const CartItem({
    Key key,
    this.uuid,
    this.price,
    this.quantity,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
          title: Text(title),
          subtitle: Text('Total: \$${(price * quantity)}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
