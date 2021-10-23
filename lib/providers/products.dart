import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exceptions.dart';

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  final String authToken;
  final String userId;

  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteItems {
    return items.where((prod) => prod.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // @override
  Future<void> addProduct(Product product) async {
    var url =
        'https://shop-app-35928-default-rtdb.firebaseio.com/products/.json?auth=$authToken';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'imageURL': product.imageUrl,
            'creatorId': userId,
          }));

      print(response.body);
      final id = json.decode(response.body)['name'];
      final newProduct = Product(
          description: product.description,
          id: json.decode(response.body)['name'],
          imageUrl: product.imageUrl,
          price: product.price,
          title: product.title);
      _items.add(newProduct);
      url =
          'https://shop-app-35928-default-rtdb.firebaseio.com/user-favourites/$userId/$id.json?auth=$authToken';
      final favResponse = await http.put(
        url,
        body: json.encode(false),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchData([bool filterByUser = false]) async {
    var filter = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://shop-app-35928-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filter';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://shop-app-35928-default-rtdb.firebaseio.com/user-favourites/$userId.json?auth=$authToken';
      final favResponse = await http.get(url);
      final favouriteData = json.decode(favResponse.body);
      print(favouriteData);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          description: prodData['description'],
          id: prodId,
          imageUrl: prodData['imageURL'],
          price: prodData['price'],
          title: prodData['title'],
          isFavourite: favouriteData == null ? false : favouriteData[prodId],
          authToken: authToken,
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateproduct(String id, Product newProd) async {
    print(id);
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://shop-app-35928-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
      http.patch(url,
          body: json.encode({
            'title': newProd.title,
            'description': newProd.description,
            'price': newProd.price,
            'imageURL': newProd.imageUrl,
          }));
      final newProduct = Product(
        description: newProd.description,
        id: id,
        imageUrl: newProd.imageUrl,
        price: newProd.price,
        title: newProd.title,
        isFavourite: newProd.isFavourite,
        authToken: authToken,
      );
      _items[prodIndex] = newProduct;
    }
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final existingProdIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProdIndex];
    var url =
        'https://shop-app-35928-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(existingProdIndex, existingProduct);
      notifyListeners();
      throw HttpExceptions('Couldn\'t delete the product!');
    } else {
      existingProduct = null;
      url =
          'https://shop-app-35928-default-rtdb.firebaseio.com/user-favourites/$userId/$id.json?auth=$authToken';
      final favResponse = await http.delete(url);
    }
  }
}
