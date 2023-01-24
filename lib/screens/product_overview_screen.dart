import 'package:flutter/material.dart';
import 'package:max_udemy_course/data/state_management/cubits/products_cubits/products_cubit.dart';
import 'package:max_udemy_course/data/state_management/providers/cart.dart';
import 'package:max_udemy_course/data/state_management/providers/products.dart';
import 'package:max_udemy_course/screens/cart_screen.dart';
import 'package:max_udemy_course/screens/my_products_screen.dart';
import 'package:max_udemy_course/screens/orders_screen.dart';
import 'package:max_udemy_course/widgets/203%20badge.dart';
import 'package:max_udemy_course/widgets/grid_view_item.dart';
import 'package:provider/provider.dart';

import '../widgets/product_item.dart';

enum FilterOptions { favorites, all }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool? showOnlyFavs = false;

  @override
  void initState() {
   Provider.of<ProductsProvider>(context , listen: false).fetchProducts();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var productsData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBar(
                title: const Text("My Shop"),
              ),ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) => const ProductOverviewScreen()));
                  },
                  title: const Text("My Shop ")),
              ListTile(
                  leading: const Icon(Icons.payment),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) => const OrdersScreen()));
                  },
                  title: const Text("My Orders")),
              ListTile(
                  leading: const Icon(Icons.edit),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) => MyProductsScreen()));
                  },
                  title: const Text("Manage Products ")) ,

            ],
          )),
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {});
                if (selectedValue == FilterOptions.favorites) {
                  showOnlyFavs = true;
                }
                if (selectedValue == FilterOptions.all) {
                  showOnlyFavs = false;
                }
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (ctx) => [
                    const PopupMenuItem(
                        value: FilterOptions.all, child: Text("Show All")),
                    const PopupMenuItem(
                      value: FilterOptions.favorites,
                      child: Text("Only Favorites"),
                    )
                  ]),
          Consumer<Cart>(
              builder: (context, provider, child) => Badge(
                  value: provider.itemCount.toString(),
                  color: Colors.deepOrange,
                  child: child!),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => MyCart()));
                },
              ))
        ],
        title: const Text("My Shop"),
      ),
      body: GridViewItem(showOnlyFavs!),
    );
  }
}
