import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/cart.dart';

import '../pages/product_details_page.dart';

class ProductItem extends StatelessWidget {
  //const ProductItem({ Key? key }) : super(key: key);
  // final String id;
  // final String title;
  // final String imgUrl;
  // final double price;

  // ProductItem({
  //   this.id,
  //   this.imgUrl,
  //   this.price,
  //   this.title,
  // });

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailsPage.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        header: Container(
            color: Colors.black87,
            child: Text(
              product.title,
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                  product.isFavourite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              tooltip: 'Add to Favourites',
              onPressed: () {
                product.toggleFavourite();
              },
            ),
          ),
          title: FittedBox(
            child: Text(
              '\$${product.price.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            tooltip: 'Add to Cart',
            onPressed: () {
              cart.addProduct(product.id, product.title, product.price, 1);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                  content: Text(
                    'Added to cart!',
                    // textAlign: TextAlign.center,
                  ),
                  duration: Duration(
                    seconds: 2,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
