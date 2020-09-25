import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The line below allow us to set a connection to one of the provided
    // classes and therefore I can use provider of in a widget has some
    // direct or indirect parent widget wich set up a provider which we
    // did in the main.dart.

    // I tell flutter where the provider package that I'm interested in
    // an instance of that products class, by tacking advantage of the fact that
    // the of method here on the provider class provided by the provider package
    // is a generic method which means I can add these angular brackets (<>) to
    // let it know to which type of data I actually want to listening to.
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (context, index) => ProductItem(
        id: products[index].id,
        title: products[index].title,
        imageUrl: products[index].imageUrl,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
