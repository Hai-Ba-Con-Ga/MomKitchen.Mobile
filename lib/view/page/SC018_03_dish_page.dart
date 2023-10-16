import 'package:flutter/material.dart';

import '../widgets/base_ListTile.dart';

class DishPage extends StatefulWidget {
  const DishPage({super.key});

  @override
  State<DishPage> createState() => _DishPageState();
}

class _DishPageState extends State<DishPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(itemBuilder: (context, index) {
        return BaseListTile(
          icon: const Icon(Icons.image, color: Colors.red, size: 50),
          title: const Text('Mon Ngon', style: TextStyle(fontSize: 20)),
          description: const Text(
            'Giao tinh quan tu nhat nhu nuoc',
            style: TextStyle(color: Color.fromRGBO(50, 52, 62, 1)),
          ),
          time: const Text('10-10-2021'),
          trailing: Container(
            width: 20,
            height: 100,
            alignment: Alignment.center,
            child: const Column(children: [
              Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(Icons.edit, color: Colors.red, size: 20),
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(Icons.delete, color: Colors.red, size: 20),
              ),
            ]),
          ),
        );
      }),
    );
  }
}
