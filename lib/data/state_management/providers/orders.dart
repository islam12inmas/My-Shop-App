import 'package:flutter/foundation.dart';

import 'cart.dart';

class Order {
  String? id;
  double? amount;
  List<CartItem>? products;
  DateTime? date;

  Order({this.id, this.products, this.amount, this.date});
}

class Orders with ChangeNotifier {
   List<Order> _orders = [];

  List<Order> get listOfOrders {
    return [..._orders];
  }

  addOrder(List<CartItem> cartProducts, double amount) {
    _orders.insert(
      0,
      Order(
          id: DateTime.now().toString(),
          amount: amount,
          date: DateTime.now(),
          products: cartProducts),
    );
    notifyListeners();
  }
}
