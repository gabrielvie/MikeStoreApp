import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';

class ProductsDetailsScreen extends StatelessWidget {
  static const String routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final productUuid = ModalRoute.of(context).settings.arguments as String;
    final productProvider = Provider.of<ProductsProvider>(context);
    final product = productProvider.findByUuid(productUuid);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
