import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:max_udemy_course/data/state_management/providers/cart.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  String? title;
  double? price;
  int? quantity;
  String? productID;

  CartWidget(
      {super.key, this.title, this.price, this.quantity, this.productID});

  @override
  Widget build(BuildContext context) {
    var cartData = Provider.of<Cart>(context);
    return quantity == 0
        ? Container()
        : Dismissible(
            confirmDismiss: (direction) {
              return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: const Text("Are You Sure?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: const Text("Yes")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Text("No"))
                        ],
                      ));
            },
            onDismissed: (direction) {
              direction == DismissDirection.endToStart
                  ? cartData.removeFromCart(productID)
                  : cartData.removeSingleItem(productID!);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product dismissed')));
            },
            key: ValueKey(productID),
            background: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.delete),
                  )),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child:
                            FittedBox(child: Text("\$ ${price.toString()}"))),
                    title: Text(title!),
                    trailing: Text(quantity.toString()),
                    subtitle: Text(
                      "Total:${quantity! * price!}\$",
                    )),
              ),
            ),
          );
  }
}
