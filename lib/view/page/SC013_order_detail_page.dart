import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../widgets/button_back.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ButtonBack(onPressed: () => context.go(AppPath.home)),
        backgroundColor: Color.fromRGBO(30, 30, 46, 1),
        foregroundColor: Color.fromRGBO(30, 30, 46, 1),
        surfaceTintColor: Color.fromRGBO(30, 30, 46, 1),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(30, 30, 46, 1)),
        child: ListView(
            controller: _controller, // Sử dụng ScrollController
            // physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Text(
                "Your Order",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Theme.of(context).textTheme.headline1?.fontSize),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Please give this QR code to the\n kitchen owner to confirm order",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          Theme.of(context).textTheme.bodyLarge?.fontSize),
                  textAlign: TextAlign.center,
                ),
              ),
              Icon(Icons.qr_code, size: 250, color: Colors.white),
              GestureDetector(
                onTap: () {
                  _controller.animateTo(1000,
                      duration: Duration(seconds: 1), curve: Curves.easeInOut);
                },
                child: Container(
                  height: 500,
                  // margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Information",
                      style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.fontSize),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
