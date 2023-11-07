import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/kitchen_api.dart';
import '../../router/router.dart';
import '../widgets/button_orange.dart';

class KitchenHome extends StatefulWidget {
  const KitchenHome({super.key});

  @override
  State<KitchenHome> createState() => _KitchenHomeState();
}

class _KitchenHomeState extends State<KitchenHome> {
  String _kitchenName = 'Default Kitchen';

  @override
  void initState() {
    super.initState();
    getKitchenNameFromSharedPreferences();
  }

  // Hàm để đọc "KitchenName" từ SharedPreferences
  Future<void> getKitchenNameFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final kitchenData = await KitchenApi().getKitchen(prefs.getString('kitchenId') ?? '');

    if (kitchenData != null) {
      setState(() {
        _kitchenName = 'hi ${kitchenData.name!}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_kitchenName),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: ButtonOrange(
              title: 'Quản Lý Bếp',
              onPressed: () => context.push('${AppPath.kitchenmanager}/0'),
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
                decoration: BoxDecoration(
                  //make shadow for border
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
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
                decoration: BoxDecoration(
                  //make shadow for border
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
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
                decoration: BoxDecoration(
                  //make shadow for border
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
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
          Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: ButtonOrange(
              title: 'Quản lý đơn hàng',
              onPressed: () => context.push('${AppPath.kitchenmanager}/0'),
            ),
          ),
        ],
      )),
    );
  }
}
