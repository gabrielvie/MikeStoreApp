import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopapp/providers/product.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/screens/products_edit.dart';

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
              onPressed: () {
                Navigator.of(context).pushNamed(ProductsEditScreen.routeName,
                    arguments: product.uuid);
              },
              color: Theme.of(context).accentColor,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<ProductsProvider>(context, listen: false)
                    .deleteProduct(product.uuid);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
