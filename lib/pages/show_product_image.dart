import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ShowProductImage extends StatelessWidget {
  static const routeName = '/show-image';
  // const ShowProductImage({ Key? key }) : super(key: key);
  final String id;

  ShowProductImage(this.id);

  @override
  Widget build(BuildContext context) {
    final productData =
        Provider.of<Products>(context, listen: false).findById(id);
    final imageUrl = productData.imageUrl;
    final Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(productData.title),
      ),
      body: Container(
        height: mediaQuery.height,
        width: mediaQuery.width,
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
