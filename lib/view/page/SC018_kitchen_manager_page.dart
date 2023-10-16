import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../widgets/button_back.dart';
import 'SC018_01_meal_page.dart';
import 'SC018_02_tray_page.dart';
import 'SC018_03_dish_page.dart';

class KitchenManager extends StatefulWidget {
  const KitchenManager({super.key});

  @override
  State<KitchenManager> createState() => KitchenManagerState();
}

class KitchenManagerState extends State<KitchenManager> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: ButtonBack(onPressed: () => context.go(AppPath.home)),
          leadingWidth: 70,
          toolbarHeight: 80,
          title: const Text('Kitchen manager'),
          bottom: const TabBar(
            labelColor: Color(0xFFFF7622),
            unselectedLabelColor: Color(0xFFA5A7B9),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Color(0xFFFF7622),
            tabs: <Widget>[
              Tab(
                // icon: Icon(Icons.cloud_outlined),
                text: 'Bữa ăn',
              ),
              Tab(
                  // icon: Icon(Icons.beach_access_sharp),
                  text: 'Mâm cơm'),
              Tab(
                  // icon: Icon(Icons.brightness_5_sharp),
                  text: 'Món ăn'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            MealPage(),
            TrayPage(),
            DishPage(),
          ],
        ),
      ),
    );
  }
}
