import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../widgets/base_ListTile.dart';
import '../widgets/button_back.dart';

class KitchenMapPage extends StatefulWidget {
  const KitchenMapPage({super.key});

  @override
  State<KitchenMapPage> createState() => _KitchenMapPageState();
}

class _KitchenMapPageState extends State<KitchenMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ButtonBack(onPressed: () => context.go(AppPath.home)),
        leadingWidth: 70,
        toolbarHeight: 100,
        title: const Text('Location'),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return BaseListTile(
              icon: Icon(Icons.notifications, color: Colors.red),
              title: Text("notification", style: TextStyle(fontSize: 20)),
              description: Text(
                'Giao tinh quan tu nhat nhu nuoc, ket giao tieu nhan ngot ruou nong',
                style: TextStyle(color: Color.fromRGBO(50, 52, 62, 1)),
              ),
            );
          },
          itemCount: 20),
    );
  }
}
