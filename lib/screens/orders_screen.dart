import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _isLoading = true;
    });

    Provider.of<Orders>(
      context,
      listen: false,
    ).fetchAndSetOrders().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _refreshOrders(BuildContext context) async {
    await Provider.of<Orders>(
      context,
      listen: false,
    ).fetchAndSetOrders();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => _refreshOrders(context),
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    OrderItem(orderData.orders[index]),
                itemCount: orderData.orders.length,
              ),
            ),
    );
  }
}
