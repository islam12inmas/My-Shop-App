import 'dart:core';
import 'package:flutter/foundation.dart';
class Product with ChangeNotifier{
  String? id;
  String? title;
  String? description;
  double? price;
  String? imageUrl;
  bool? isFavorite ;

  Product({
    this.id,
     this.title,
    this.description,
   this.imageUrl,
    this.price,
     this.isFavorite = false,

  });
  void makeFavorite () {
    isFavorite = !isFavorite!;
    notifyListeners();
  }
}