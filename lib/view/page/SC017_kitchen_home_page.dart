import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../widgets/button_orange.dart';

class KitchenHome extends StatefulWidget {
  const KitchenHome({super.key});

  @override
  State<KitchenHome> createState() => _KitchenHomeState();
}

class _KitchenHomeState extends State<KitchenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitchen owner name'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: ButtonOrange(
              title: 'Kitchen Manager',
              onPressed: () => context.go('${AppPath.kitchenmanager}/0'),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Quản lý đơn ăn"), Icon(Icons.arrow_forward_ios_rounded, size: 15)]),
          ),
          Container(
            height: 150,
            padding: EdgeInsets.all(5),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                color: Colors.green,
                height: 100,
                width: 80,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Icon(Icons.pending_actions),
                    SizedBox(height: 10),
                    Text("Chờ đến ăn"),
                  ],
                ),
              ),
              Container(
                color: Colors.green,
                height: 100,
                width: 80,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Icon(Icons.dinner_dining),
                    SizedBox(height: 10),
                    Text("Đang ăn"),
                  ],
                ),
              ),
              Container(
                color: Colors.green,
                height: 100,
                width: 80,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Icon(Icons.done),
                    SizedBox(height: 10),
                    Text("Đã ăn"),
                  ],
                ),
              ),
            ]),
          ),
        ],
      )),
    );
  }
}
