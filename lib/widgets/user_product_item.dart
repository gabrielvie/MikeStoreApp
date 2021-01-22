import 'package:flutter/material.dart';

import 'package:shopapp/providers/product.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  const UserProductItem({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
              color: Theme.of(context).accentColor,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {},
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
