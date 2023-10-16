import 'package:flutter/material.dart';

class MealPage extends StatefulWidget {
  const MealPage({super.key});

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return Container(
        // width: 50,
        height: 200,
        child: Card(
          elevation: 0,
          color: const Color(0xFFECF0F4),
          child: Column(children: [
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
                )
              ],
            ),
            Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {},
                        child: const Text('Sửa',
                            style: TextStyle(color: Colors.white))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {},
                        child: const Text('Sửa',
                            style: TextStyle(color: Colors.white))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {},
                        child: const Text('Sửa',
                            style: TextStyle(color: Colors.white))),
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