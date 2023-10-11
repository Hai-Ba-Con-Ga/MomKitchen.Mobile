import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../widgets/button_orange.dart';
import '../widgets/home/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leadingWidth: 300,
            leading: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                prefixIcon: GestureDetector(
                  onTap: () => context.go(AppPath.search),
                  child: Icon(Icons.search),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () => context.go(AppPath.notification),
              ),
            ]),
        body: ListView(
          children: [
            ButtonOrange(
              title: 'My Orders',
              icon: Icons.assignment,
              onPressed: () => context.go(AppPath.orderdetail),
            ),
            ButtonOrange(
                title: 'Select Location',
                icon: Icons.location_on,
                onPressed: () => context.go(AppPath.kitchenmap)),
            ListDish(title: 'Recent kitchen'),
            ListDish(title: 'Favorite kitchen'),
            ListDish(title: 'Top Trending kitchen'),
          ],
        ));
  }
}
