import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:max_udemy_course/data/state_management/providers/products.dart';
import 'package:max_udemy_course/screens/add_products_screen.dart';
import 'package:max_udemy_course/screens/customize_products_screen.dart';
import 'package:provider/provider.dart';

class ManageProductsItem extends StatelessWidget {
  String? title;
  String? imageUrl;
  String? id;

  ManageProductsItem({super.key, this.title, this.imageUrl, this.id});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(title!),
      trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        CustomizeProductsScreen.routeName,
                        arguments: id);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  )),
              IconButton(
                  onPressed: () {
                    Provider.of<ProductsProvider>(context , listen: false).deleteProduct(id!);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          )),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl!)),
    ));
  }
}
