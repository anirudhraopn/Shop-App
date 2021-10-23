// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helpers/custom_route.dart';
import 'package:shop_app/pages/auth_page.dart';
import 'package:shop_app/pages/edit_product_page.dart';
import 'package:shop_app/pages/orders_page.dart';
import 'package:shop_app/pages/show_product_image.dart';
import 'package:shop_app/pages/splash_page.dart';
import 'package:shop_app/pages/user_products_page.dart';
import 'package:shop_app/providers/auth.dart';
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
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: (ctx) => Products('', '', []),
            update: (ctx, authData, previousProductsData) => Products(
                  authData.token,
                  authData.userId,
                  previousProductsData == null
                      ? []
                      : previousProductsData.items,
                )),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders('', '', []),
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.items,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: authData.isAuth
              ? ProductsOverviewPage()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashPage()
                          : AuthPage(),
                ),
          title: 'Shop App',
          theme: ThemeData(
              primarySwatch: Colors.indigo,
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android: CustomPageTrasnsition(),
                TargetPlatform.iOS: CustomPageTrasnsition(),
              }),
              accentColor: Colors.amber,
              fontFamily: GoogleFonts.lato().fontFamily,
              accentTextTheme: TextTheme(
                  title: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ))),
          routes: {
            ProductsOverviewPage.routeName: (ctx) => ProductsOverviewPage(),
            ProductDetailsPage.routeName: (ctx) => ProductDetailsPage(),
            CartPage.routeName: (ctx) => CartPage(),
            OrdersPage.routeName: (ctx) => OrdersPage(),
            UserProductsPage.routeName: (ctx) => UserProductsPage(),
            EditProductPage.routeName: (ctx) => EditProductPage(),
            // ShowProductImage.routeName:(ctx)=>ShowProductImage(),
          },
        ),
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