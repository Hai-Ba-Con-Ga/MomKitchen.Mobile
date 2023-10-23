import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';

class BaseScaffoldKitchen extends StatefulWidget {
  final Widget child;

  const BaseScaffoldKitchen({
    super.key,
    required this.child,
  });

  @override
  State<BaseScaffoldKitchen> createState() => _BaseScaffoldKitchenState();
}

class _BaseScaffoldKitchenState extends State<BaseScaffoldKitchen> {
  int _selectedIndex = 0;

  final _bottomNavigationItemList = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'User',
      // backgroundColor: Colors.lightBlueAccent,
    ),
  ];

  void _onItemTapped(int index, BuildContext context) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        context.go(AppPath.kitchenhome);
        break;
      case 1:
        context.go(AppPath.kitchenprofile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widget.child,
      ),
      bottomNavigationBar: Container(
        height: 60,
        // color: Colors.transparent,
        decoration: BoxDecoration(
          color: Colors.white, // Màu nền của BottomNavigationBar
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
            ),
          ],
        ),
        child: BottomNavigationBar(
          iconSize: 25,
          items: _bottomNavigationItemList,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: const Color(0xFFBDBDBD),
          currentIndex: _selectedIndex,
          onTap: (index) => _onItemTapped(
            index,
            context,
          ),
        ),
      ),
    );
  }
}
