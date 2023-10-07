import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';

class BaseScaffold extends StatefulWidget {
  final Widget child;
  // int _selectedIndex = 3;
  // TextStyle? optionStyle;
  // List<Widget>? _widgetOptions;

  const BaseScaffold({
    super.key,
    required this.child,
  });

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  int _selectedIndex = 0;

  final _bottomNavigationItemList = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      // backgroundColor: Colors.lightBlueAccent,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.map),
      label: 'Favorite',
      // backgroundColor: Colors.red,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Notification',
      // backgroundColor: Colors.tealAccent,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
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
        context.go(AppPath.home);
        break;
      case 1:
        context.go(AppPath.favorite);
        break;
      case 2:
        context.go(AppPath.notification);
        break;
      case 3:
        context.go(AppPath.user);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         'Mom Kitchen',
      //         style: Theme.of(context).textTheme.titleLarge,
      //       ),
      //     ],
      //   ),
      //   // leading: const SizedBox.shrink(),
      //   // actions: [
      //   //   IconButton(
      //   //     icon: const Icon(Icons.notifications),
      //   //     onPressed: () {
      //   //       Navigator.push(
      //   //         context,
      //   //         MaterialPageRoute(
      //   //           builder: (context) => const NotificationPage(),
      //   //         ),
      //   //       );
      //   //     },
      //   //   ),
      //   // ],
      // ),
      body: Center(
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize:
            Theme.of(context).textTheme.bodyMedium?.fontSize?.toDouble() ??
                24.0,
        items: _bottomNavigationItemList,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: const Color.fromARGB(
          255,
          255,
          215,
          166,
        ),
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(
          index,
          context,
        ),
      ),
    );
  }
}
