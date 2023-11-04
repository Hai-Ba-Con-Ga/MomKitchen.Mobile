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
  int selectedPaymentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop(AppPath.order)),
        title: const Text('Payment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 130,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PaymentItem(
                        'VnPay', Image.asset('assets/images/payment_1.png'), 0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PaymentItem('MasterCard',
                        Image.asset('assets/images/payment_2.png'), 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PaymentItem(
                        'Momo', Image.asset('assets/images/payment_3.png'), 2),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PaymentItem(
                        'Visa', Image.asset('assets/images/payment_4.png'), 3),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              color: Colors.amber[100],
              width: double.infinity,
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(left: 20),
        child: ButtonOrange(
          onPressed: () => context.pop(),
          title: 'XÁC NHẬN',
        ),
      ),
    );
  }

  Container PaymentItem(String name, Image img, int index) {
    bool isSelected = (index == selectedPaymentIndex);
    return Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : const Color(0xFFF0F5FA),
        borderRadius: BorderRadius.circular(10.0),
        // border: Border.all(
        //   width: 2.0,
        //   color: isSelected
        //       ? Colors.orange
        //       : const Color(0xFFF0F5FA), // Đổi màu viền tương ứng
        // ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedPaymentIndex = isSelected ? -1 : index;
                });
              },
              child: SizedBox(
                width: 60,
                height: 50,
                child: img,
              ),
            ),
          ),
          Text(name),
        ],
      ),
    );
  }
}
