import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../../utils/palette.dart';
import '../widgets/button_back.dart';
import 'SC018_01_meal_page.dart';
import 'SC018_02_tray_page.dart';
import 'SC018_03_dish_page.dart';

class KitchenManager extends StatefulWidget {
  const KitchenManager({super.key, this.selectedTab});
  final int? selectedTab;

  @override
  State<KitchenManager> createState() => KitchenManagerState();
}

class KitchenManagerState extends State<KitchenManager>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _currentTabIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, vsync: this, initialIndex: widget.selectedTab ?? 0);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.selectedTab ?? 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: ButtonBack(onPressed: () => context.pop()),
          leadingWidth: 70,
          toolbarHeight: 80,
          title: const Text('Quản Lý Bếp'),
          bottom: TabBar(
            controller: _tabController,
            labelColor: const Color(0xFFFF7622),
            unselectedLabelColor: const Color(0xFFA5A7B9),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: const Color(0xFFFF7622),
            tabs: <Widget>[
              const Tab(
                text: 'Bữa ăn',
              ),
              const Tab(text: 'Mâm cơm'),
              const Tab(text: 'Món ăn'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            MealPage(),
            TrayPage(),
            DishPage(),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     switch (_currentTabIndex) {
        //       case 0:
        //         context.push(AppPath.addmeal);
        //         break;
        //       case 1:
        //         context.push(AppPath.addtray);
        //         break;
        //       case 2:
        //         context.push(AppPath.adddish);
        //         break;
        //     }
        //   },
        //   child: const Icon(Icons.add),
        //   backgroundColor: primaryColor,
        // ),
      ),
    );
  }
}
