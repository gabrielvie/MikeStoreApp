import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/screens/cart.dart';
import 'package:shopapp/widgets/badge.dart';

import 'package:shopapp/widgets/product_grid.dart';

enum FilterOptions {
  Desired,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const String routeName = '/product-list';

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyDesired = false;

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: _showOnlyDesired
            ? const Text('ShopApp - Favorites')
            : const Text('ShopApp - All'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions filterOption) {
              setState(() {
                if (filterOption == FilterOptions.Desired) {
                  _showOnlyDesired = true;
                } else {
                  _showOnlyDesired = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Desired,
              ),
              PopupMenuItem(
                child: Text('Show all'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<CartProvider>(
            builder: (_, cartProvider, child) => Badge(
              child: child,
              value: cartProvider.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
            ),
          ),
        ],
      ),
      body: ProductsGrid(
        showOnlyDesired: _showOnlyDesired,
      ),
    );
    return scaffold;
  }
}
