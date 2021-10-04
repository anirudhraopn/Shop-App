import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final String id;
  final double price;
  final int quantity;

  CartItem({
    @required this.id,
    @required this.price,
    this.quantity,
    @required this.title,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addProduct(String prodId, String title, double price, int quantity) {
    if (_items.containsKey(prodId)) {
      _items.update(
          prodId,
          (currentVal) => CartItem(
                id: currentVal.id,
                price: currentVal.price,
                quantity: currentVal.quantity + 1,
                title: currentVal.title,
              ));
    } else {
      _items.putIfAbsent(
          prodId,
          () => CartItem(
              id: prodId, price: price, quantity: quantity, title: title));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id].quantity > 1) {
      _items.update(
          id,
          (eValue) => CartItem(
                id: eValue.id,
                price: eValue.price,
                title: eValue.title,
                quantity: eValue.quantity - 1,
              ));
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
