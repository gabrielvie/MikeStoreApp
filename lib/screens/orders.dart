// Flutter imports.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// App imports.
import 'package:mikestore/providers/orders.dart' show OrdersProvider;
import 'package:mikestore/widgets/app_drawer.dart';
import 'package:mikestore/widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _orders;

  @override
  void initState() {
    super.initState();
    _orders = _getOrders();
  }

  _getOrders() async {
    OrdersProvider ordersProvider = Provider.of(context, listen: false);
    await ordersProvider.fetch();
    return ordersProvider.items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Orders!')),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _orders,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              return Consumer<OrdersProvider>(
                builder: (context, ordersData, child) => ListView.builder(
                  itemBuilder: (_, i) => OrderItem(order: ordersData.items[i]),
                  itemCount: ordersData.items.length,
                ),
              );
            default:
              return Center(
                child: const Text('There\'s somenting wrong with this app.'),
              );
          }
        },
      ),
    );
  }
}
