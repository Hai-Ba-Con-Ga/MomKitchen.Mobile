import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'notification_page.dart';

class FooterBar extends StatelessWidget {
  final Widget child;
  // int _selectedIndex = 3;
  // TextStyle? optionStyle;
  // List<Widget>? _widgetOptions;

  const FooterBar({
    super.key,
    required this.child,
  });

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/map');
        break;
      case 1:
        context.go('/favorite');
        break;
      case 2:
        context.go('/list');
        break;
      case 3:
        context.go('/setting');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Mom Kitchen',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: Theme.of(context).textTheme.bodyMedium?.fontSize?.toDouble() ?? 24.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            // backgroundColor: Colors.lightBlueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
            // backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'person',
            // backgroundColor: Colors.tealAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
            // backgroundColor: Colors.lightBlueAccent,
          ),
        ],
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: const Color.fromARGB(
          255,
          255,
          215,
          166,
        ),
        onTap: (index) => _onItemTapped(
          index,
          context,
        ),
      ),
    );
  }
}
