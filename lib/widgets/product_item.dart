import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shopapp/models/product.dart';
import 'package:shopapp/screens/products_details.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductsDetailsScreen.routeName,
              arguments: product.uuid,
            );
          },
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
      ),
    );
  }
}
