import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exceptions.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavourite = false;

  Product({
    @required this.description,
    @required this.id,
    @required this.imageUrl,
    @required this.price,
    @required this.title,
    this.isFavourite = false,
  });

  void toggleFavourite() async {
    final url =
        'https://shop-app-35928-default-rtdb.firebaseio.com/products/$id.json';
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    try {
      final response = await http.patch(url,
          body: json.encode({'isFavourite': isFavourite}));
      if (response.statusCode >= 400) {
        throw HttpExceptions('There was an error!');
      }
    } catch (error) {
      isFavourite = oldStatus;
      notifyListeners();
    }
  }
}
