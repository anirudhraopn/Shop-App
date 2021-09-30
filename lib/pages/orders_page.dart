import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/OrderItem.dart';
import 'package:shop_app/widgets/main_drawer.dart';

import '../providers/orders.dart';

class OrdersPage extends StatelessWidget {
  static const routeName = '/orders-page';
  // const OrdersPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(
          'Your Orders',
        ),
      ),
      body: ListView.builder(
        itemCount: orderData.items.length,
        itemBuilder: (ctx, i) => OrderItem(
          orderData.items[i],
        ),
      ),
    );
  }
}
