import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // If I reuse and existing object tiku in the products_grid.dart I should
      // use the dot value provider with the value I'm providing as we're doing
      // in that file.
      // When I create a new instance of Object and I want to provide this, I
      // use the create or the builder method.
      create: (_) => Products(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.cyan,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
