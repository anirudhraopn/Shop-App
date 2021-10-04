// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/edit_product_page.dart';
import 'package:shop_app/pages/orders_page.dart';
import 'package:shop_app/pages/user_products_page.dart';
import 'package:shop_app/providers/orders.dart';
import './pages/cart_page.dart';

import 'package:shop_app/pages/product_details_page.dart';
import 'package:shop_app/pages/products_overview_page.dart';
import './providers/products.dart';
import './providers/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductsOverviewPage(),
        title: 'Shop App',
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
            fontFamily: GoogleFonts.lato().fontFamily,
            accentTextTheme: TextTheme(
                title: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ))),
        routes: {
          ProductDetailsPage.routeName: (ctx) => ProductDetailsPage(),
          CartPage.routeName: (ctx) => CartPage(),
          OrdersPage.routeName: (ctx) => OrdersPage(),
          UserProductsPage.routeName: (ctx) => UserProductsPage(),
          EditProductPage.routeName: (ctx) => EditProductPage(),
        },
      ),
    );
  }
}

// class MyHome extends StatelessWidget {
//   //const MyHome({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }