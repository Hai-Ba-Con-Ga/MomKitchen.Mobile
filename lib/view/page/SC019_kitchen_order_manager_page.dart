import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../../utils/palette.dart';
import '../widgets/button_back.dart';
import 'SC018_01_meal_page.dart';
import 'SC018_02_tray_page.dart';
import 'SC018_03_dish_page.dart';
import 'SC020_paid_order_page.dart';

class KitchenOrderManager extends StatefulWidget {
  const KitchenOrderManager({super.key, this.selectedTab});
  final int? selectedTab;

  @override
  State<KitchenOrderManager> createState() => KitchenOrderManagerState();
}

class KitchenOrderManagerState extends State<KitchenOrderManager> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _currentTabIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: widget.selectedTab ?? 0);
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
          title: const Text('Quản Lý Đơn Hàng'),
          bottom: TabBar(
            controller: _tabController,
            labelColor: const Color(0xFFFF7622),
            unselectedLabelColor: const Color(0xFFA5A7B9),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: const Color(0xFFFF7622),
            tabs: <Widget>[
              const Tab(text: 'Đang đợi '),
              const Tab(text: 'Đã Hoàn Thành'),
              const Tab(text: 'Đã Hủy'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            PaidOrderPage(orderStatus: 'PAID'),
            PaidOrderPage(orderStatus: 'COMPLETED'),
            PaidOrderPage(orderStatus: 'CANCELED'),
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
