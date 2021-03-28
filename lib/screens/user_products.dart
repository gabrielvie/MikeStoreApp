// Flutter imports.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// App imports.
import 'package:mikestore/providers/products.dart';
import 'package:mikestore/screens/products_edit.dart';
import 'package:mikestore/widgets/app_drawer.dart';
import 'package:mikestore/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const String routeName = '/user-product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(ProductsEditScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              return RefreshIndicator(
                onRefresh: () => _refreshProducts(context),
                child: Consumer<ProductsProvider>(
                  builder: (context, productsProvider, _) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                      itemBuilder: (_, index) => Column(
                        children: <Widget>[
                          UserProductItem(
                            product: productsProvider.items[index],
                          ),
                          Divider(),
                        ],
                      ),
                      itemCount: productsProvider.items.length,
                    ),
                  ),
                ),
              );
            default:
              return Center(
                child: const Text('There\'s somenting wrong with this app.'),
              );
          }
        },
      ),
    );
  }

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false).fetch(true);
  }
}
