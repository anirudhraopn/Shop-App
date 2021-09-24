// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/pages/product_details_page.dart';
import 'package:shop_app/pages/products_overview_page.dart';
import './providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductsOverviewPage(),
        title: 'Shop App',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          fontFamily: GoogleFonts.lato().fontFamily,
        ),
        routes: {
          ProductDetailsPage.routeName: (ctx) => ProductDetailsPage(),
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