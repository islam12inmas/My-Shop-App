import 'package:flutter/cupertino.dart';
import 'package:max_udemy_course/data/state_management/cubits/products_cubits/products_cubit.dart';
import 'package:max_udemy_course/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../data/state_management/providers/products.dart';

class GridViewItem extends StatefulWidget {
  bool showOnlyFavs;

  GridViewItem(this.showOnlyFavs, {super.key});



  @override
  State<GridViewItem> createState() => _GridViewItemState();
}

class _GridViewItemState extends State<GridViewItem> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var productsData = Provider.of<ProductsProvider>(context);
    final products = widget.showOnlyFavs
        ? productsData.favoriteProducts
        : productsData.products;
    return GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemBuilder: (context, i) => ChangeNotifierProvider.value(
              value: products[i],
              child: ProductItem(
                  products[i].id,
                  products[i].title,
                  products[i].imageUrl ??
                      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg'),
            ));
  }
}
