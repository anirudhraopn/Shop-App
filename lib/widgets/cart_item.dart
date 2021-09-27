import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  // const CartItem({ Key? key }) : super(key: key);
  final String id;
  final String prodId;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    this.id,
    this.price,
    this.quantity,
    this.title,
    this.prodId,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      background: Container(
        color: Theme.of(context).errorColor,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(
            Icons.delete,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.removeItem(prodId);
      },
      key: ValueKey(id),
      child: Card(
        color: Theme.of(context).primaryColorLight,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            // radius: 50,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text(
                  '\$${(price * quantity)}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            'Quantity: $quantity',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ),
    );
  }
}
