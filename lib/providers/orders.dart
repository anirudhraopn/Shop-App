import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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
  List<OrderItems> _items = [];

  List<OrderItems> get items {
    return [..._items];
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    final timeStamp = DateTime.now();
    const url =
        'https://shop-app-35928-default-rtdb.firebaseio.com/orders.json';
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProduct.map((cp) {
            return {
              'id': cp.id,
              'title': cp.title,
              'quantity': cp.quantity,
              'price': cp.price,
            };
          }).toList(),
        }));
    _items.insert(
        0,
        OrderItems(
          amount: total,
          dateTime: timeStamp,
          id: json.decode(response.body)['name'],
          products: cartProduct,
        ));

    notifyListeners();
  }

  Future<void> fetchOrders() async {
    const url =
        'https://shop-app-35928-default-rtdb.firebaseio.com/orders.json';
    List<OrderItems> loadedProducts = [];
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    print(extractedData);
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedProducts.add(
        OrderItems(
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          id: orderId,
          products: (orderData['products'] as List<dynamic>)
              .map(
                (order) => CartItem(
                  id: order['id'],
                  price: order['price'],
                  title: order['title'],
                  quantity: order['quantity'],
                ),
              )
              .toList(),
        ),
      );
    });
    _items = loadedProducts.reversed.toList();
    notifyListeners();
  }
}
