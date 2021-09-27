import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  var showFavs = false;

  ProductsGrid(this.showFavs);
  // const ProductsGrid({
  //   Key key,
  //   @required this.products,
  // }) : super(key: key);

  // final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = showFavs ? productData.favouriteItems : productData.items;
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(
            // id: products[i].id,
            // imgUrl: products[i].imageUrl,
            // price: products[i].price,
            // title: products[i].title,
            ),
      ),
      itemCount: products.length,
    );
  }
}
