import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:max_udemy_course/data/state_management/providers/products.dart';
import 'package:max_udemy_course/screens/add_products_screen.dart';
import 'package:max_udemy_course/screens/product_overview_screen.dart';
import 'package:max_udemy_course/widgets/manage_product_item.dart';
import 'package:provider/provider.dart';

import 'orders_screen.dart';

class MyProductsScreen extends StatelessWidget {
  const MyProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var productsData = Provider.of<ProductsProvider>(context);
    Future<void> _refreshProducts() async {
      await Provider.of<ProductsProvider>(context, listen: false)
          .fetchProducts();
    }

    return Scaffold(
      drawer: Drawer(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppBar(
            title: const Text("My Shop"),
          ),
          ListTile(
              leading: const Icon(Icons.shopping_cart),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const ProductOverviewScreen()));
              },
              title: const Text("My Shop ")),
          ListTile(
              leading: const Icon(Icons.payment),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const OrdersScreen()));
              },
              title: const Text("My Orders")),
          ListTile(
              leading: const Icon(Icons.edit),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => MyProductsScreen()));
              },
              title: const Text("Manage Products ")),
        ],
      )),
      appBar: AppBar(title: const Text("My Products"), actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: '');
            },
            icon: const Icon(Icons.add))
      ]),
      body: RefreshIndicator(
        onRefresh: _refreshProducts,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: (ctx, i) => ManageProductsItem(
                id: productsData.products[i].id,
                title: productsData.products[i].title,
                imageUrl: productsData.products[i].imageUrl),
            itemCount: productsData.products.length,
          ),
        ),
      ),
    );
  }
}
