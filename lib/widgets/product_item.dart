// Flutter imports.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// App imports.
import 'package:mikestore/models/product.dart';
import 'package:mikestore/screens/products_details.dart';
import 'package:mikestore/providers/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    // final cartProvider = Provider.of<CartProvider>(context, listen: false);

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
              arguments: product.id,
            );
          },
        ),
        // FIXME: Fix this to avoid error
        /*header: Container(
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
        ),*/
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            color: Theme.of(context).primaryColor,
            onPressed: () => _addProductToCart(context, product),
          ),
        ),
      ),
    );
  }

  Future<void> _addProductToCart(BuildContext context, Product product) async {
    CartProvider cartProvider = Provider.of(context, listen: false);

    await cartProvider.addItem(product);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added item to cart'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => cartProvider.removeSingleItem(product.id),
        ),
      ),
    );
  }
}
