import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:max_udemy_course/data/state_management/providers/cart.dart';
import 'package:max_udemy_course/data/state_management/providers/orders.dart';
import 'package:max_udemy_course/screens/customize_products_screen.dart';
import 'package:max_udemy_course/screens/product_overview_screen.dart';
import './data/state_management/providers/products.dart';
import './screens/add_products_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (ctx) => ProductsProvider()),
      ChangeNotifierProvider(create: (ctx) => Cart()),  
      ChangeNotifierProvider(create: (ctx)=>Orders())
    ],
      child: MaterialApp( debugShowCheckedModeBanner: false,
      title: 'My Shop',
      theme: ThemeData(
      primaryColor: Colors.teal,
      accentColor: Colors.amber,
      primarySwatch: Colors.cyan,
    ),
    home: const ProductOverviewScreen() ,
          routes:{
          EditProductScreen.routeName: (ctx)=> EditProductScreen(),
            CustomizeProductsScreen.routeName: (ctx) =>  CustomizeProductsScreen()
          } ),

    );
  }
}
