import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import '../data/state_management/providers/orders.dart';

class OrderWidget extends StatefulWidget {
  final Order order;

  OrderWidget({super.key, required this.order});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              title: Text("\$${widget.order.amount}"),
              subtitle: Text(
                  DateFormat("dd/MM/yyyy hh:mm").format(widget.order.date!)),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded!;
                  });
                },
                icon: Icon(_expanded
                    ? Icons.expand_less
                    : Icons.expand_circle_down_rounded)),
            if (_expanded)
              Container(
                  height:100,
                  child: ListView(
                      children: widget.order.products!
                          .map((e) =>
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(e.title! , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w700)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${e.quantity} x \$${e.price}" , style: TextStyle(fontSize: 14 , color: Colors.grey)),
                                    )
                                  ]))
                          .toList()))
          ],
        ));
  }
}
