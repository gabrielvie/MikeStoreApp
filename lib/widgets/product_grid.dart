// Flutter imports.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// App imports
import 'package:mikestore/providers/products.dart';
import 'package:mikestore/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyDesired;

  ProductsGrid({this.showOnlyDesired = false});

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final products = showOnlyDesired
        ? productsProvider.desiredItems
        : productsProvider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
