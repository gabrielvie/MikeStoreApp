import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shopapp/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
      ),
      header: Container(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: product.isDesired
              ? Icon(Icons.favorite, color: Colors.red)
              : Icon(Icons.favorite_outline, color: Colors.black54),
          onPressed: () {},
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          icon: Icon(Icons.add_shopping_cart),
          color: Theme.of(context).primaryColor,
          onPressed: () {},
        ),
      ),
    );
  }
}
