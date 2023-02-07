import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  String? id;
  String? title;
  String? description;
  double? price;
  String? imageUrl;
  bool? isFavorite;

  Product({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.price,
    this.isFavorite = false,
  });

  Future<void> makeFavorite( String? token, String? userId) async {
    final url = Uri.parse(
        'https://course-udemy-max-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token');

    isFavorite = !isFavorite!;
    var oldFav = isFavorite;
    notifyListeners();
    try {
      await http.put(url, body: json.encode(isFavorite));
    } catch (error) {
      isFavorite = oldFav;
    }
  }
}
