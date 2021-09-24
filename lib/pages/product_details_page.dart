// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailsPage extends StatelessWidget {
  // const ProductDetailsPage({ Key? key }) : super(key: key);
  static const routeName = '/product-details';
  // final String title;

  // ProductDetailsPage(this.title);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
        centerTitle: false,
      ),
    );
  }
}
