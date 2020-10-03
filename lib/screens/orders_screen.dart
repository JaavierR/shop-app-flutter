import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  Future<void> _refreshOrders(BuildContext context) async {
    await Provider.of<Orders>(
      context,
      listen: false,
    ).fetchAndSetOrders();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      // The FutureBuilder allows me to not transform this widget into a
      // stateful and also allows me not to use an extra variable to see which
      // widget to load. (_isLoading variable)
      body: FutureBuilder(
          future: Provider.of<Orders>(
            context,
            listen: false,
          ).fetchAndSetOrders(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.error != null) {
                // Error handling...
                return Center(
                  child: Text('An error ocurred!'),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () => _refreshOrders(context),
                  child: Consumer<Orders>(
                    builder: (context, orderData, child) => ListView.builder(
                      itemBuilder: (context, index) =>
                          OrderItem(orderData.orders[index]),
                      itemCount: orderData.orders.length,
                    ),
                  ),
                );
              }
            }
          }),
    );
  }
}
