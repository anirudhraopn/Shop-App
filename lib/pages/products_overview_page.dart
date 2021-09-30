import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/main_drawer.dart';

// import 'package:shop_app/widgets/product_item.dart';
// import '../providers/product.dart';
import './cart_page.dart';
import '../providers/cart.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';

class ProductsOverviewPage extends StatefulWidget {
  static const routeName = '/';
  //const ({ Key? key }) : super(key: key);

  @override
  _ProductsOverviewPageState createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  var _showOnlyFavs = false;
  @override
  Widget build(BuildContext context) {
    //final cart = Provider.of<Cart>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(
          'My Shop',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        actions: [
          Consumer<Cart>(
            builder: (_, cart, iconbutton) => Badge(
              child: iconbutton,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
            ),
          ),
          PopupMenuButton(
            onSelected: (int selectedVal) {
              setState(() {
                if (selectedVal == 0) {
                  _showOnlyFavs = true;
                } else {
                  _showOnlyFavs = false;
                }
              });
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: 0,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: 1,
              ),
            ],
          ),
        ],
      ),
      body: ProductsGrid(showFavs: _showOnlyFavs),
    );
  }
}
