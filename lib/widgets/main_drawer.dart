import 'package:flutter/material.dart';
import 'package:shop_app/pages/orders_page.dart';
import 'package:shop_app/pages/products_overview_page.dart';
import 'package:shop_app/pages/user_products_page.dart';

class MainDrawer extends StatelessWidget {
  // const MainDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          child: Column(
        children: [
          AppBar(
            title: Text(
              'My Shop',
            ),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.shop,
              color: Theme.of(context).primaryColorDark,
            ),
            title: Text(
              'Shop',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductsOverviewPage.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.payment,
              color: Theme.of(context).primaryColorDark,
            ),
            title: Text(
              'My Orders',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrdersPage.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.edit,
              color: Theme.of(context).primaryColorDark,
            ),
            title: Text(
              'Manage Products',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsPage.routeName);
            },
          )
        ],
      )),
    );
  }
}
