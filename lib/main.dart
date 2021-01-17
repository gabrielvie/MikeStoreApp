import 'package:flutter/material.dart';

import 'package:shopapp/screens/products_details.dart';
import 'package:shopapp/screens/products_overview.dart';
import 'package:shopapp/utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: Constants.lightTheme,
      home: ProductsOverviewScreen(),
      initialRoute: ProductsOverviewScreen.routeName,
      routes: {
        ProductsOverviewScreen.routeName: (context) => ProductsOverviewScreen(),
        ProductsDetailsScreen.routeName: (context) => ProductsDetailsScreen(),
      },
    );
  }
}
