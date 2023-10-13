import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../widgets/button_orange.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Payment"),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            Container(
              height: 100,
              color: Colors.red,
              width: double.infinity,
              child: Row(
                children: [
                  // ListView.builder(
                  //   itemBuilder: (context, index) {
                  //     return Container(
                  //         width: 50, height: 50, child: Text("123"));
                  //   },
                  //   itemCount: 10,
                  // ),
                ],
              ),
            )
          ],
        )),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 20),
        child: ButtonOrange(
          onPressed: () => context.go(AppPath.payment),
          title: "XÁC NHẬN",
        ),
      ),
    );
  }
}
