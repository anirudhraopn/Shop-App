import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  // const Cart({ Key? key }) : super(key: key);
  static const routeName = '/Cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Consumer<Cart>(
        builder: (_, cart, __) => Column(
          children: [
            Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Total :',
                      style: Theme.of(context).textTheme.title,
                    ),
                    Spacer(),
                    Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text('${cart.totalAmount}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).accentColor,
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: 80,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        onPressed: () {
                          Provider.of<Orders>(context, listen: false).addOrder(
                              cart.items.values.toList(), cart.totalAmount);
                          cart.clearCart();
                        },
                        child: Text(
                          'PLACE ORDER',
                          softWrap: true,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (ctx, i) => CartItem(
                  id: cart.items.values.toList()[i].id,
                  price: cart.items.values.toList()[i].price,
                  title: cart.items.values.toList()[i].title,
                  quantity: cart.items.values.toList()[i].quantity,
                  prodId: cart.items.keys.toList()[i],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
