import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../router/router.dart';
import '../widgets/base_ListTile.dart';
import '../widgets/button_back.dart';

class KitchenNotificationPage extends StatefulWidget {
  const KitchenNotificationPage({super.key});

  @override
  State<KitchenNotificationPage> createState() => _KitchenNotificationPageState();
}

class _KitchenNotificationPageState extends State<KitchenNotificationPage> {
  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(time);
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 70,
          toolbarHeight: 100,
          title: const Text('Thông Báo'),
        ),
        body: Container(
          child: ListView.builder(
              itemBuilder: (context, index) {
                return BaseListTile(
                  icon: const Icon(Icons.notifications, color: Colors.red),
                  title: const Text(
                    'Thông báo',
                    style: TextStyle(fontSize: 20),
                  ),
                  description: const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: TextStyle(color: Color.fromRGBO(50, 52, 62, 1)),
                  ),
                  time: Text(formattedDate),
                );
              },
              itemCount: 20),
        ));
  }
}
