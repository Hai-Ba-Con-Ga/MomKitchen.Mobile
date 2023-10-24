import 'package:dio/dio.dart';
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.go(AppPath.mealdetail)),
        title: const Text('Bữa ăn'),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          // height: 2000,
          width: double.infinity,
          child: Column(
            children: [
              Card(
                // margin: const EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 120, // Độ rộng của hình ảnh món ăn
                        height: 120, // Chiều cao của hình ảnh món ăn
                        child: Image.network(
                          'https://cdn.britannica.com/36/123536-050-95CB0C6E/Variety-fruits-vegetables.jpg',
                          width: 200, // Độ rộng của hình ảnh
                          height: 200, // Chiều cao của hình ảnh
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Buổi tối sang chảnh của miền Tây',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Bếp: nhà miền tây',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              '1000\$',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: null,
                  ),
                  Text(
                    '3',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: null,
                  ),
                ],
              ),
              Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 100,
                  color: Colors.cyan,
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Ngày 20 Tháng 11 Năm 2023',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('Buổi tối : 8 giờ.',
                                style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.cyan,
                      ),
                      onPressed: () => {context.go(AppPath.payment)},
                      child: const Text(
                        'Chọn phương thức thanh toán',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Color.fromARGB(255, 188, 221, 248),
        height: 120,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Tổng Số Tiền: 60\$',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                width: 350,
                child: ButtonOrange(
                  title: 'Click me',
                  onPressed: null,
                  icon: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
