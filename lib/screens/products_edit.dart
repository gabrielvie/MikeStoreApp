// Flutter imports.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// App imports.
import 'package:mikestore/models/product.dart';
import 'package:mikestore/providers/products.dart';
import 'package:mikestore/utils/constants.dart';

enum FormFields {
  Title,
  Price,
  Description,
  ImageUrl,
}

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
    id: null,
    creatorId: null,
    title: '',
    imageUrl: '',
    description: '',
    price: 0,
  );

  bool _isInit = true;
  bool _isLoading = false;

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

    _imageUrlController.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct = Provider.of<ProductsProvider>(context).find(productId);
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
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
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _productForm,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue: _editedProduct.title,
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
                        _editedProduct.title = value;
                      },
                      validator: (value) =>
                          _validateForm(FormFields.Title, value),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue: _editedProduct.price <= 0
                          ? null // Added to not provide 0.0 if price doesn't exists.
                          : _editedProduct.price.toString(),
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
                        _editedProduct.price = double.parse(value);
                      },
                      validator: (value) =>
                          _validateForm(FormFields.Price, value),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue: _editedProduct.description,
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
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        });
                      },
                      onSaved: (value) {
                        _editedProduct.description = value;
                      },
                      validator: (value) =>
                          _validateForm(FormFields.Description, value),
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
                                  child:
                                      Image.network(_imageUrlController.text),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            // initialValue: _editedProduct.imageUrl,
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
                              _editedProduct.imageUrl = value;
                            },
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) =>
                                _validateForm(FormFields.ImageUrl, value),
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

  Future<void> _saveForm() async {
    final isValid = _productForm.currentState.validate();

    if (!isValid) {
      return;
    }

    _productForm.currentState.save();
    setState(() {
      _isLoading = true;
    });

    ProductsProvider productsProvider = Provider.of(context);
    if (_editedProduct.id != null) {
      await productsProvider.update(_editedProduct);
    } else {
      try {
        await productsProvider.create(_editedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  String _validateForm(FormFields field, String value) {
    String validationMessage;

    switch (field) {
      case FormFields.Title:
        if (value.isEmpty) {
          validationMessage = 'The title field is required.';
        }
        break;
      case FormFields.Price:
        if (value.isEmpty) {
          validationMessage = 'The price field is required.';
        } else if (double.parse(value) <= 0) {
          validationMessage = 'The price must be grater than 0.';
        }
        break;
      case FormFields.Description:
        if (value.isEmpty) {
          validationMessage = 'The description field is required.';
        }
        break;
      case FormFields.ImageUrl:
        if (value.isEmpty) {
          validationMessage = 'The image URL field is required.';
        } else if (!value.startsWith('http') && !value.startsWith('https')) {
          validationMessage = 'Provide a valid url.';
        } else if (!value.endsWith('.png') &&
            !value.endsWith('.jpg') &&
            !value.endsWith('.jpeg')) {
          validationMessage =
              'Provid a valid image url. Valid formats: .jpg, .jpeg, .png';
        }
        break;
    }

    return validationMessage;
  }
}
