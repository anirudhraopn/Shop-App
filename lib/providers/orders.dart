import 'package:flutter/foundation.dart';

import './cart.dart';

class OrderItems {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItems({
    @required this.amount,
    @required this.dateTime,
    @required this.id,
    @required this.products,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItems> _items = [];

  List<OrderItems> get items {
    return [..._items];
  }

  void addOrder(List<CartItem> cartProduct, double total) {
    _items.insert(
        0,
        OrderItems(
          amount: total,
          dateTime: DateTime.now(),
          id: DateTime.now().toString(),
          products: cartProduct,
        ));

    notifyListeners();
  }
}
