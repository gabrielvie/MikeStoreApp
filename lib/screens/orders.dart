// Flutter imports.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// App imports.
import 'package:mikestore/providers/orders.dart' show OrdersProvider;
import 'package:mikestore/widgets/app_drawer.dart';
import 'package:mikestore/widgets/order_item.dart';

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
