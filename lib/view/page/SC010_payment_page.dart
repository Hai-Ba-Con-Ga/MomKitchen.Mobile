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
        leading: BackButton(onPressed: () => context.go(AppPath.order)),
        title: const Text('Payment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              color: Colors.red,
              width: double.infinity,
              child: const Column(
                children: [
                  Text('Payment Page'),
                ],
              ),
            ),
            Text('hehe'),
            Text('hehe'),
            Text('hehe'),
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(left: 20),
        child: ButtonOrange(
          onPressed: () => context.go(AppPath.payment),
          title: 'XÁC NHẬN',
        ),
      ),
    );
  }
}
