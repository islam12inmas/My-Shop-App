import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:max_udemy_course/data/state_management/providers/auth.dart';
import 'package:max_udemy_course/data/state_management/providers/cart.dart';
import 'package:max_udemy_course/data/state_management/providers/orders.dart';
import 'package:max_udemy_course/screens/customize_products_screen.dart';
import 'package:max_udemy_course/screens/product_overview_screen.dart';
import './data/state_management/providers/products.dart';
import './screens/add_products_screen.dart';
import 'package:provider/provider.dart';
import './screens/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          create: (BuildContext context) {
            return ProductsProvider([]);
          },
          update: (BuildContext context, auth, previous) {
            return ProductsProvider(previous!.products,
                authToken: auth.token, userId: auth.userId);
          },
        ),
        ChangeNotifierProxyProvider<Auth, Cart>(
            create: (ctx) => Cart(),
            update: ((context, auth, previous) {
              return Cart();
            })),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders([]),
          update: (context, auth, previous) {
            return Orders(previous!.listOfOrders,
                token: auth.token, userId: auth.userId);
          },
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'My Shop',
              theme: ThemeData(
                primaryColor: Colors.teal,
                accentColor: Colors.amber,
                primarySwatch: Colors.cyan,
              ),
              home: auth.token !=null? const ProductOverviewScreen() :
            AuthScreen(),
              routes: {
                EditProductScreen.routeName: (ctx) => EditProductScreen(),
                CustomizeProductsScreen.routeName: (ctx) =>
                    const CustomizeProductsScreen()
              });
        },
      ),
    );
  }
}
