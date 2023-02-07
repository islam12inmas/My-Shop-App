import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'cart.dart';
import 'package:http/http.dart' as http;

class Order {
  String? id;
  double? amount;
  List<CartItem>? products;
  DateTime? date;

  Order({this.id, this.products, this.amount, this.date});
}

class Orders with ChangeNotifier {
  String? token;
String? userId;
  Orders(this._orders, {this.token , this.userId});

  List<Order> _orders = [];

  List<Order> get listOfOrders {
    return [..._orders];
  }

  Future<dynamic> fetchOrders() async {
    final url = Uri.parse(
        'https://course-udemy-max-default-rtdb.firebaseio.com/orders/$userId.json?auth=$token');
    var response = await http.get(url);
    final decoded = json.decode(response.body) as Map<String, dynamic>;
    final List<Order> newOrders = [];
    if (decoded == null) {
      return{};
    }
    decoded.forEach((id, order) {
      newOrders.add(Order(
          id: id,
          date: DateTime.parse(order['date']),
          amount: order['amount'],
          products: (order['products'] as List<dynamic>)
              .map((e) => CartItem(
                  id: e['id'],
                  price: e['price'],
                  title: e['title'],
                  quantity: e['quantity']))
              .toList()));
      _orders = newOrders.reversed.toList();
      notifyListeners();
    });
  }

  Future<void> addOrder(List<CartItem> cartProducts, double amount) async {
    DateTime dateNow = DateTime.now();
    final url = Uri.parse(
        'https://course-udemy-max-default-rtdb.firebaseio.com/orders/$userId.json?auth=$token');
    final response = await http.post(url,
        body: json.encode({
          'amount': amount,
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'price': e.price,
                    'quantity': e.quantity,
                    'title': e.title
                  })
              .toList(),
          'date': dateNow.toIso8601String()
        }));

    _orders.insert(
      0,
      Order(
          id: json.decode(response.body)['name'],
          amount: amount,
          date: dateNow,
          products: cartProducts),
    );
    notifyListeners();
  }
}
