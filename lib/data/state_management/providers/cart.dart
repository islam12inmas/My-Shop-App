import 'package:flutter/cupertino.dart';

class CartItem {
  String? id;
  String? title;
  double? price;
  int? quantity;

  CartItem({this.id, this.title, this.price, this.quantity});
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> _items = {};

  Map<String, CartItem> get cartItems {
    return {..._items};
  }

  int get itemCount {
    return _items.length ?? 0;
  }

  void addToCart(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              price: existingCartItem.price,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity! + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              price: price,
              title: title,
              id: DateTime.now().toString(),
              quantity: 1));
    }
    notifyListeners();
  }

  double? get totalPrice {
    var totalAmount = 0.0;
    _items.forEach(
        (key, CartItem) => totalAmount += CartItem.price! * CartItem.quantity!);
    return totalAmount;
  }

  removeFromCart(productId) {
    _items.remove(productId);
    notifyListeners();
  }

  reduceQuantity(productID) {
    _items.update(
        productID,
        (value) => CartItem(
            title: value.title,
            price: value.price,
            id: value.id,
            quantity: value.quantity! - 1));
  }

  clearCart() {
    _items = {};
    notifyListeners();
  }

  removeSingleItem(productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity! > 1) {
      _items.update(
          productId,
          (value) => CartItem(
              title: value.title,
              id: value.id,
              price: value.price,
              quantity: value.quantity! - 1));
    } else {
      _items.remove(productId!);
    }
    notifyListeners();
  }
}
