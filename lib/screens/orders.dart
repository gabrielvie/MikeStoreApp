import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopapp/providers/orders.dart' show OrdersProvider;
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Orders!')),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (_, index) => OrderItem(
          order: ordersProvider.items[index],
        ),
        itemCount: ordersProvider.items.length,
      ),
    );
  }
}
