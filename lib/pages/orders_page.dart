import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';
import '../widgets/main_drawer.dart';

import '../providers/orders.dart';

class OrdersPage extends StatelessWidget {
  static const routeName = '/orders-page';

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text(
            'Your Orders',
          ),
        ),
        body: FutureBuilder(
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An error occurred'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (ctx, orderData, child) => ListView.builder(
                    itemCount: orderData.items.length,
                    itemBuilder: (ctx, i) => OrderItem(
                      orderData.items[i],
                    ),
                  ),
                );
              }
            }
          },
          future: Provider.of<Orders>(context, listen: false).fetchOrders(),
        ));
  }
}
