import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen({
  //   this.title,
  //   this.price,
  // });
  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    // This extract the id from the product item. This is a central state
    // management solution.
    final productId = ModalRoute.of(context).settings.arguments as String;
    // I want to get all my product data for that id...
    // The logic want to move out of our widgets into our provider class, so
    // the widget is a bit leaner
    final loadedProduct = Provider.of<Products>(
      context,
      // The listen argument set to true, the build method of the widget in wich
      // I'm using provider of will rerun whenever the provided object changes.
      // With listen set to false, this widget will not rebuild if
      // notifyListener is called because it's not set up as an active listener
      // and that is something I should do if I only need data one time.
      listen: false,
    ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
