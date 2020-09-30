import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import '../screens/product_detail_screen.dart';

// I only use Stateful widget to change how something is displayed inside of a
// widget (avoid using provider-provider class)
// In this widget we use provider because the data related to if is favorite or
// not, does not only matter to this widget.
class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem({
  //   this.id,
  //   this.title,
  //   this.imageUrl,
  // });

  // Using the Consumer<Product> we can wrap a specific part of the widget tree
  // to listen the nearest product but Consumer always listen to changes and
  // I then rebuild the icon button whenever the product changes.
  // With this approach I also need to set via the .of<Product>, but with
  // the listen set to false, because I only need once some of the information.

  @override
  Widget build(BuildContext context) {
    // This always trigger the whole build method because it's a method or a
    // way of extracting data and storing it in a variable.
    final product = Provider.of<Product>(
      context,
      listen: false,
    );
    final refreshProducts = Provider.of<Products>(
      context,
      listen: false,
    );
    final cart = Provider.of<Cart>(
      context,
      listen: false,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              // Forward the id property that we've in this file, to the named
              // route, not all the data... continue in detail_screen.dart
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () {
                product.toggleFavoriteStatus();
                refreshProducts.refreshProductList();
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(
                productId: product.id,
                price: product.price,
                title: product.title,
              );
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added item to cart!'),
                  duration: Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
