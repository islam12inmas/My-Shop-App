import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:max_udemy_course/data/state_management/providers/cart.dart';
import 'package:max_udemy_course/data/state_management/providers/orders.dart';
import 'package:max_udemy_course/screens/orders_screen.dart';
import 'package:max_udemy_course/widgets/cart_widget.dart';
import 'package:provider/provider.dart';

class MyCart extends StatelessWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartData = Provider.of<Cart>(context);
    var order = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Total", style: TextStyle(fontSize: 20)),
                ),
                const Spacer(),
                Chip(
                    label: Text("\$ ${cartData.totalPrice}"),
                    backgroundColor: Theme.of(context).primaryColor),
                TextButton(
                    onPressed: () {
                      order.addOrder(cartData.cartItems.values.toList(),
                          cartData.totalPrice!);
                      cartData.clearCart();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          action: SnackBarAction(
                              label: "Go To Orders",
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => OrdersScreen()));
                              }),
                          content: Text("Order Placed!")));
                    },
                    child: const Text("ORDER NOW"))
              ],
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: cartData.itemCount,
                itemBuilder: (ctx, i) => CartWidget(
                      productID: cartData.cartItems.keys.toList()[i],
                      title: cartData.cartItems.values.toList()[i].title,
                      quantity: cartData.cartItems.values.toList()[i].quantity,
                      price: cartData.cartItems.values.toList()[i].price,
                    )))
      ]),
    );
  }
}
