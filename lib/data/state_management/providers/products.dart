import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product.dart';

class ProductsProvider with ChangeNotifier {
  final String? authToken;
  final String? userId;

  ProductsProvider(this._products, {this.authToken, this.userId});

  List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get products {
    return [..._products];
  }

  List<Product> get favoriteProducts {
    return _products.where((element) => element.isFavorite!).toList();
  }

  addProduct(Product product) async {
    final url = Uri.parse(
        'https://course-udemy-max-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'creatorID': userId
          }));

      final newProduct = Product(
          price: product.price,
          title: product.title,
          imageUrl: product.imageUrl,
          description: product.description,
          id: json.decode(response.body)['name']);
      _products.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Product findByID(String? id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final url = Uri.parse(
        'https://course-udemy-max-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
    await http.patch(url,
        body: json.encode({
          'title': newProduct.title,
          'price': newProduct.price,
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl
        }));

    var index = _products.indexWhere((element) => element.id == id);

    _products[index] = newProduct;

    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://course-udemy-max-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
    var index = _products.indexWhere((element) => element.id == id);
    Product? deletedProduct = _products[index];
    _products.removeWhere((element) => element.id == id);
    await http.delete(url).then((response) {
      if (response.statusCode >= 400) {
        _products.insert(index, deletedProduct!);
      } else {
        deletedProduct = null;
      }
    });

    notifyListeners();
  }

  Future<void> fetchProducts([bool filter = false]) async {
    final filtering = filter ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = Uri.parse(
        'https://course-udemy-max-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filtering');
    try {
      final response = await http.get(url);
      var decoded = json.decode(response.body) as Map<String, dynamic>;
      url = Uri.parse(
          'https://course-udemy-max-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken');
      var favResponse = await http.get(url);
      var favData = json.decode(favResponse.body);
      List<Product> productList = [];
      decoded.forEach((id, prod) {
        productList.add(Product(
            id: id,
            isFavorite: favData == null ? false : favData[id] ?? false,
            description: prod['description'],
            imageUrl: prod['imageUrl'],
            title: prod['title'],
            price: prod['price']));
      });
      _products = productList;
      notifyListeners();
    } catch (error) {
      rethrow;
      //test
    }
  }
}
