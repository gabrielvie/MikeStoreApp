import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopapp/providers/product.dart';
import 'package:shopapp/screens/products_details.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);

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
          // Rebuilds only this part of code if product changes.
          child: Consumer<Product>(
            builder: (context, product, child) => IconButton(
              icon: product.isDesired
                  ? Icon(Icons.favorite, color: Colors.red)
                  : Icon(Icons.favorite_outline, color: Colors.black54),
              onPressed: () => product.toogleFavoriteStatus(),
            ),
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
