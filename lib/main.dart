import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/screens/cart.dart';

import 'package:shopapp/screens/products_details.dart';
import 'package:shopapp/screens/products_overview.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => ProductsProvider()),
        ChangeNotifierProvider(builder: (_) => CartProvider()),
        ChangeNotifierProvider(builder: (_) => OrdersProvider()),
      ],
      child: MaterialApp(
        title: Constants.appName,
        theme: Constants.lightTheme,
        initialRoute: ProductsOverviewScreen.routeName,
        routes: {
          ProductsOverviewScreen.routeName: (_) => ProductsOverviewScreen(),
          ProductsDetailsScreen.routeName: (_) => ProductsDetailsScreen(),
          CartScreen.routeName: (_) => CartScreen(),
        },
      ),
    );
  }
}
