import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mikestore/models/product.dart';
import 'package:mikestore/providers/products.dart';
import 'package:mikestore/providers/user.dart';
import 'package:mikestore/widgets/app_drawer.dart';

class ProductsDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';

  @override
  _ProductsDetailsScreenState createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  ProductsProvider productsProvider;
  UserProvider userProvider;

  Product _product;
  bool _isFavorite = false;

  @override
  void didChangeDependencies() {
    productsProvider = Provider.of(context, listen: false);
    userProvider = Provider.of(context);

    String productId = ModalRoute.of(context).settings.arguments;
    _product = productsProvider.find(productId);

    setState(() {
      _isFavorite = userProvider.isFavorite(_product);
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_product.title),
        actions: <Widget>[
          IconButton(
            icon: _isFavorite
                ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.favorite_outline,
                    color: Colors.grey[350],
                  ),
            onPressed: () async {
              await userProvider.addOrRemoveFavorite(_product);
              setState(() {
                _isFavorite = userProvider.isFavorite(_product);
              });
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                _product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${_product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                _product.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
