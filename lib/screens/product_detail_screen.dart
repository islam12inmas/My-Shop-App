import 'package:flutter/material.dart';
import 'package:max_udemy_course/data/state_management/providers/products.dart';
import 'package:max_udemy_course/reusable_components/custom_container.dart';
import 'package:max_udemy_course/reusable_components/custom_text.dart';
import 'package:provider/provider.dart';



class ProductDetailScreen extends StatelessWidget {
  final String? id;

  const ProductDetailScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    var loadedProduct = Provider.of<ProductsProvider>(context , listen: false).findByID(id!);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title!),
      ),
      body: Column(
        children: [
          SizedBox(height: 300, width: double.infinity, child: Image.network(loadedProduct.imageUrl!)),

           Padding(
             padding: const EdgeInsets.all(8.0),
             child: CustomText(text: loadedProduct.title , fontSize: 24 , color: Colors.red),
           ),
          CustomContainer(width: double.infinity, height:50 , text:"\$${loadedProduct.price.toString()}" , textSize: 18,)


        ],
      ),
    );
  }
}
