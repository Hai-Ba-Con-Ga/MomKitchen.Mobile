import 'package:flutter/material.dart';

class TrayPage extends StatefulWidget {
  const TrayPage({super.key});

  @override
  State<TrayPage> createState() => _TrayPageState();
}

class _TrayPageState extends State<TrayPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return Container(
        // width: 50,
        height: 200,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Card(
          elevation: 0,
          color: const Color(0xFFECF0F4),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.image, color: Colors.red, size: 100),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tên Món Ăn', style: TextStyle(fontSize: 20)),
                        Text(
                          'Thể thao thiên bẩm',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text('5 Suất ăn'),
                      ],
                    ),
                  ],
                ),
                Container(
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 50,
                        width: 100,
                        padding: const EdgeInsets.all(10.0),
                        child: TextButton(
                            onPressed: () {},
                            child: const Text('Sửa',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12))),
                      ),
                      Container(
                        height: 50,
                        width: 100,
                        padding: const EdgeInsets.all(10.0),
                        child: TextButton(
                            onPressed: () {},
                            child: const Text('ẩn',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12))),
                      ),
                      Container(
                        height: 50,
                        width: 100,
                        padding: const EdgeInsets.all(10.0),
                        child: TextButton(
                            onPressed: () {},
                            child: const Text('đánh giá',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12))),
                      ),
                    ],
                  ),
                )
              ]),
        ),
      );
    });
  }
}
