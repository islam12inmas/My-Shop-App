import './get_products_request.dart';
import './get_products_request.dart';
import 'package:max_udemy_course/domain/products_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetProductsRequest {
  static void getProducts(
      Function(ProductsModel) onSuccess, Function(int error) onError) async {
    await http
        .get(Uri.parse(
            'https://course-udemy-max-default-rtdb.firebaseio.com/products.json'))
        .then((response) {
      Map<String, dynamic> decoded;
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        decoded = json.decode(response.body);
        ProductsModel products = ProductsModel.fromJson(decoded);

        onSuccess(products);
        onError(404);
      }
    });
  }
}
