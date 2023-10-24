import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../router/router.dart';
import '../widgets/base_ListTile.dart';
import '../widgets/button_back.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(time);
    return Scaffold(
        appBar: AppBar(
          leading: ButtonBack(onPressed: () => context.pop()),
          leadingWidth: 70,
          toolbarHeight: 100,
          title: const Text('Notification'),
        ),
        body: Container(
          child: ListView.builder(
              itemBuilder: (context, index) {
                return BaseListTile(
                  icon: const Icon(Icons.notifications, color: Colors.red),
                  title: const Text("notification", style: TextStyle(fontSize: 20)),
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
