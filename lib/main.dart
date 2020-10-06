import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './screens/auth_screen.dart';
import './screens/cart_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/user_products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          // Set up a provider wich itself depends on another provider which
          // was defined before this one. So Auth() provider need to be the
          // first one on the list.
          // Now this provider will be rebuilt when the previous (Auth) changes,
          // because the Auth object is now a dependency of this provider. i.e.
          // a new Products object would be built when of changes.
          create: null,
          update: (_, auth, previousProduct) => Products(
            auth.token,
            previousProduct == null ? [] : previousProduct.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Cart>(
          // If I reuse and existing object tiku in the products_grid.dart I should
          // use the dot value provider with the value I'm providing as we're doing
          // in that file.
          // When I create a new instance of Object and I want to provide this, I
          // use the create or the builder method.
          create: null,
          update: (_, auth, previousCart) => Cart(
            auth.token,
            previousCart == null ? {} : previousCart.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: null,
          update: (_, auth, previousOrders) => Orders(
            auth.token,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.cyan,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
