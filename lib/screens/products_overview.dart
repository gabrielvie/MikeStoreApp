import 'package:flutter/material.dart';

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
          )
        ],
      ),
      body: ProductsGrid(
        showOnlyDesired: _showOnlyDesired,
      ),
    );
    return scaffold;
  }
}
