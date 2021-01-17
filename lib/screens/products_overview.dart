import 'package:flutter/material.dart';

import 'package:shopapp/models/product.dart';
import 'package:shopapp/widgets/product_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const String routeName = '/product-list';

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(title: const Text('ShopApp')),
      body: ProductsGrid(),
    );
    return scaffold;
  }
}
