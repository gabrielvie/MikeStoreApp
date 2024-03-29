// Flutter imports.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// App imports.
import 'package:mikestore/providers/auth.dart';
import 'package:mikestore/providers/cart.dart';
import 'package:mikestore/providers/orders.dart';
import 'package:mikestore/providers/user.dart';
import 'package:mikestore/screens/auth.dart';
import 'package:mikestore/screens/cart.dart';
import 'package:mikestore/screens/orders.dart';
import 'package:mikestore/screens/products_details.dart';
import 'package:mikestore/screens/products_edit.dart';
import 'package:mikestore/screens/products_overview.dart';
import 'package:mikestore/providers/products.dart';
import 'package:mikestore/screens/user_products.dart';
import 'package:mikestore/utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (context) => UserProvider(),
          update: (context, authProvider, userProvider) =>
              userProvider.auth(authProvider),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          create: (context) => ProductsProvider(),
          update: (context, authProvider, productProvider) =>
              productProvider.auth(authProvider),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CartProvider>(
          create: (context) => CartProvider(),
          update: (context, authProvider, cartProvider) =>
              cartProvider.auth(authProvider),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          create: (context) => OrdersProvider(),
          update: (context, authProvider, ordersProvider) =>
              ordersProvider.auth(authProvider),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) => MaterialApp(
          title: Constants.appName,
          theme: Constants.lightTheme,
          // initialRoute: AuthScreen.routeName,
          home: auth.isAuthenticated ? ProductsOverviewScreen() : AuthScreen(),
          routes: {
            AuthScreen.routeName: (_) => AuthScreen(),
            CartScreen.routeName: (_) => CartScreen(),
            ProductsOverviewScreen.routeName: (_) => ProductsOverviewScreen(),
            ProductsDetailsScreen.routeName: (_) => ProductsDetailsScreen(),
            ProductsEditScreen.routeName: (_) => ProductsEditScreen(),
            OrdersScreen.routeName: (_) => OrdersScreen(),
            UserProductsScreen.routeName: (_) => UserProductsScreen(),
          },
        ),
      ),
    );
  }
}
