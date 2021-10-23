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
  final String authToken;

  Product({
    @required this.description,
    @required this.id,
    @required this.imageUrl,
    @required this.price,
    @required this.title,
    this.isFavourite = false,
    this.authToken,
  });

  void toggleFavourite(String userId) async {
    final url =
        'https://shop-app-35928-default-rtdb.firebaseio.com/user-favourites/$userId/$id.json?auth=$authToken';
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    try {
      final response = await http.put(url, body: json.encode(isFavourite));
      if (response.statusCode >= 400) {
        throw HttpExceptions('There was an error!');
      }
    } catch (error) {
      isFavourite = oldStatus;
      notifyListeners();
    }
  }
}
