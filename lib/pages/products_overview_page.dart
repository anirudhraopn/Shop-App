import 'package:flutter/material.dart';
// import 'package:shop_app/widgets/product_item.dart';

// import '../providers/product.dart';
import '../widgets/products_grid.dart';

class ProductsOverviewPage extends StatelessWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shop App',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: ProductsGrid(),
    );
  }
}
