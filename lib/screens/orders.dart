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
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<OrdersProvider>(context).fetch().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Orders!')),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (_, index) => OrderItem(
                order: ordersProvider.items[index],
              ),
              itemCount: ordersProvider.items.length,
            ),
    );
  }
}
