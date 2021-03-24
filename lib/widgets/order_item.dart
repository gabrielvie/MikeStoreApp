// Flutter imports.
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// App imports.
import 'package:mikestore/models/cart_item.dart';
import 'package:mikestore/models/order.dart';
import 'package:mikestore/models/product.dart';
import 'package:mikestore/providers/products.dart';

class OrderItem extends StatefulWidget {
  final Order order;

  const OrderItem({
    Key key,
    this.order,
  }) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    ProductsProvider productProvider = Provider.of(context, listen: false);

    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy HH:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.only(right: 30, left: 20),
              height: widget.order.items.length * 40 + 30.0,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  CartItem order = widget.order.items[index];
                  Product product =
                      productProvider.find(widget.order.items[index].productId);
                  return Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              child: Text(
                                '${product.title}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '${order.quantity}x \$${order.price}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15)
                    ],
                  );
                },
                itemCount: widget.order.items.length,
              ),
            )
        ],
      ),
    );
  }
}
