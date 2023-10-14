import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../widgets/button_orange.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.go(AppPath.mealdetail)),
        title: Text("Order"),
      ),
      // body: Text("123"),
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 20),
        child: ButtonOrange(
          onPressed: () => context.go(AppPath.payment),
          title: "THANH TOÁN",
        ),
      ),
    );
  }
}
