import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:max_udemy_course/data/state_management/providers/cart.dart';
import 'package:max_udemy_course/data/state_management/providers/products.dart';
import 'package:max_udemy_course/data/state_management/providers/product.dart';
import 'package:max_udemy_course/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:max_udemy_course/data/state_management/providers/cart.dart';
import 'package:max_udemy_course/data/state_management/providers/orders.dart';
import 'package:max_udemy_course/widgets/cart_widget.dart';
import 'package:provider/provider.dart';

import '../data/state_management/providers/auth.dart';

class ProductItem extends StatefulWidget {
  String? id;
  String? title;
  String? imageUrl;

  ProductItem(this.id, this.title, this.imageUrl, {super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    var thisProduct = Provider.of<Product>(context, listen: false);
    var productsData = Provider.of<ProductsProvider>(context, listen: false);
    final products = productsData.products;
    var cart = Provider.of<Cart>(context, listen: false);
    var authData = Provider.of<Auth>(context, listen: false);
    print("rebuild");
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
          footer: GridTileBar(
              backgroundColor: Colors.black54,
              leading: Consumer<Product>(
                builder: (context, product, child) => IconButton(
                    onPressed: () {
                      product.makeFavorite(
                          authData.token, authData.userId);
                    },
                    icon: Icon(
                      product.isFavorite!
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Theme.of(context).accentColor,
                    )),
              ),
              trailing: IconButton(
                  onPressed: () {
                    cart.addToCart(thisProduct.id!, thisProduct.title!,
                        thisProduct.price!);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        action: SnackBarAction(
                            label: "UNDO",
                            onPressed: () {
                              cart.removeSingleItem(thisProduct.id!);
                            }),
                        duration: const Duration(seconds: 3),
                        content: const Text(
                          "Added to Cart!",
                        )));
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).accentColor,
                  )),
              title: Text(
                widget.title!,
                textAlign: TextAlign.center,
              )),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(id: widget.id)));
            },
            child: Image.network(
              widget.imageUrl!,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
