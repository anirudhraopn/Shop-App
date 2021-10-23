import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/edit_product_page.dart';
import 'package:shop_app/widgets/user_product_Item.dart';

import '../widgets/main_drawer.dart';
import '../providers/products.dart';

class UserProductsPage extends StatefulWidget {
  // const UserProductsPage({ Key? key }) : super(key: key);
  static const routeName = '/user-products';

  @override
  _UserProductsPageState createState() => _UserProductsPageState();
}

class _UserProductsPageState extends State<UserProductsPage> {
  Future<void> _refresh(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchData(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductPage.routeName);
            },
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: _refresh(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refresh(context),
                    child: Consumer<Products>(
                      builder: (ctx, productData, _) => ListView.builder(
                        itemBuilder: (_, i) => Column(children: [
                          UserProductItem(
                            imgUrl: productData.items[i].imageUrl,
                            title: productData.items[i].title,
                            id: productData.items[i].id,
                          ),
                          Divider(),
                        ]),
                        itemCount: productData.items.length,
                      ),
                    ),
                  ),
      ),
    );
  }
}
