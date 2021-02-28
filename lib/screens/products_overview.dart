// App imports.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Flutter imports.
import 'package:mikestore/screens/cart.dart';
import 'package:mikestore/providers/cart.dart';
import 'package:mikestore/providers/products.dart';
import 'package:mikestore/widgets/app_drawer.dart';
import 'package:mikestore/widgets/badge.dart';
import 'package:mikestore/widgets/product_grid.dart';
import 'package:mikestore/utils/constants.dart';

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
  bool _isInit = true;
  bool _isLoading = false;
  bool _isLoadingCart = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
        _isLoadingCart = true;
      });

      Provider.of<ProductsProvider>(context).fetch().then((_) {
        setState(() {
          _isLoading = false;
        });
      });

      Provider.of<CartProvider>(context).fetch().then((_) {
        setState(() {
          _isLoadingCart = false;
        });
      });
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _showOnlyDesired
            ? Text(Constants.appName + ' - Favorites')
            : Text(Constants.appName + ' - All'),
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
          _isLoadingCart
              // Cart icon will stay disable waiting to fetch data.
              ? IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: null,
                )
              : Consumer<CartProvider>(
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
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductsGrid(),
    );
  }
}
