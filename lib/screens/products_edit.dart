import 'package:flutter/material.dart';

class ProductsEditScreen extends StatefulWidget {
  static const String routeName = '/product-edit';

  @override
  _ProductsEditScreenState createState() => _ProductsEditScreenState();
}

class _ProductsEditScreenState extends State<ProductsEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
