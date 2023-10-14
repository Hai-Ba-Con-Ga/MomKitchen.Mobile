import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../widgets/button_orange.dart';
import '../widgets/card_dish.dart';
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
          toolbarHeight: 100,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          leadingWidth: 50,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
                onTap: () => context.go(AppPath.home),
                child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Color(0xddddddFF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.chevron_left_sharp,
                    ))),
          ),
          title: Container(
            alignment: Alignment.centerLeft,
            child: Stack(children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  fillColor: Color(0xddddddFF),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  // conteprefixIconntPadding: EdgeInsets.only(right: 50),
                  // prefixIconConstraints: BoxConstraints(
                  //   minWidth: 80,
                  // ),
                  prefixIcon: GestureDetector(
                    onTap: () => context.go(AppPath.search),
                    child: Icon(Icons.search),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                child: IconButton(onPressed: () {}, icon: Icon(Icons.cancel)),
              )
            ]),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () => context.go(AppPath.notification),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xddddddFF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_none_sharp,
                  ),
                ),
              ),
            )
          ],
        ),
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
            ListTile(
              title: Text("Recent Kitchen"),
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CardDish(
                    onPressed: () => context.go(AppPath.mealdetail),
                  );
                },
              ),
            ),
            ListTile(
              title: Text("Top Trending"),
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CardDish(
                    onPressed: () => context.go(AppPath.mealdetail),
                  );
                },
              ),
            ),
            ListTile(
              title: Text("Favorite kitchen"),
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CardDish(
                    onPressed: () => context.go(AppPath.mealdetail),
                  );
                },
              ),
            ),
            // ListDish(title: 'Recent kitchen'),
            // ListDish(title: 'Favorite kitchen'),
            // ListDish(title: 'Top Trending kitchen'),
          ],
        ));
  }
}
