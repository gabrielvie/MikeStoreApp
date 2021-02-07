import 'package:flutter/material.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/utils/constants.dart';

class ProductsEditScreen extends StatefulWidget {
  static const String routeName = '/product-edit';

  @override
  _ProductsEditScreenState createState() => _ProductsEditScreenState();
}

class _ProductsEditScreenState extends State<ProductsEditScreen> {
  FocusNode _titleFocusNode;
  FocusNode _priceFocusNode;
  FocusNode _imageUrlFocusNode;
  FocusNode _descriptionFocusNode;

  Product _editedProduct = Product(
    null,
    title: '',
    imageUrl: '',
    description: '',
    price: 0,
  );

  final _imageUrlController = TextEditingController();
  final _productForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _titleFocusNode = FocusNode();
    _priceFocusNode = FocusNode();
    _imageUrlFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();

    _imageUrlFocusNode.addListener(_updateImageURL);
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageURL);

    _titleFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _descriptionFocusNode.dispose();

    _descriptionFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).accentColor,
        width: 2.0,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveProduct,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _productForm,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  focusedBorder: outlineInputBorder,
                  labelStyle: TextStyle(
                    color: _titleFocusNode.hasFocus
                        ? Theme.of(context).accentColor
                        : Constants.darkBG,
                  ),
                ),
                textInputAction: TextInputAction.next,
                focusNode: _titleFocusNode,
                onTap: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(_titleFocusNode);
                  });
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    _editedProduct.uuid,
                    title: value,
                    imageUrl: _editedProduct.imageUrl,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                  );
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                  focusedBorder: outlineInputBorder,
                  labelStyle: TextStyle(
                    color: _priceFocusNode.hasFocus
                        ? Theme.of(context).accentColor
                        : Constants.darkBG,
                  ),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onTap: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  });
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    _editedProduct.uuid,
                    title: _editedProduct.title,
                    imageUrl: _editedProduct.imageUrl,
                    description: _editedProduct.description,
                    price: double.parse(value),
                  );
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  focusedBorder: outlineInputBorder,
                  labelStyle: TextStyle(
                    color: _descriptionFocusNode.hasFocus
                        ? Theme.of(context).accentColor
                        : Constants.darkBG,
                  ),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                onTap: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  });
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    _editedProduct.uuid,
                    title: _editedProduct.title,
                    imageUrl: _editedProduct.imageUrl,
                    description: value,
                    price: _editedProduct.price,
                  );
                },
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _imageUrlFocusNode.hasFocus
                            ? Theme.of(context).accentColor
                            : Constants.darkBG,
                        width: 1,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text(
                            "Enter a URL",
                            style: TextStyle(
                              color: _imageUrlFocusNode.hasFocus
                                  ? Theme.of(context).accentColor
                                  : Constants.darkBG,
                            ),
                          )
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Image URL',
                        focusedBorder: outlineInputBorder,
                        labelStyle: TextStyle(
                          color: _imageUrlFocusNode.hasFocus
                              ? Theme.of(context).accentColor
                              : Constants.darkBG,
                        ),
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onTap: () {
                        setState(() {
                          FocusScope.of(context)
                              .requestFocus(_imageUrlFocusNode);
                        });
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          _editedProduct.uuid,
                          title: _editedProduct.title,
                          imageUrl: value,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                        );
                      },
                      onFieldSubmitted: (_) {
                        _saveProduct();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateImageURL() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveProduct() {
    _productForm.currentState.save();
  }
}
