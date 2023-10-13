import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../widgets/button_back.dart';
import '../widgets/card_dish.dart';
import '../widgets/search/search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Container(
            height: 40,
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Bán chạy   |   Gần đây   |   Giá <> "),
                  Image.asset(
                    "assets/images/Filter.png",
                    height: 30,
                    width: 30,
                  )
                ]),
          ),
        ),
      ),
      body: NestedScrollView(
        // Setting floatHeaderSlivers to true is required in order to float
        // the outer slivers over the inner scrollable.
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text('Floating Nested SliverAppBar'),
              floating: true,
              expandedHeight: 200.0,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: Column(
          children: [
            Text("123"),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                // crossAxisSpacing: 10.0,
                // mainAxisSpacing: 10.0,
                childAspectRatio: 95 / 100,
                children: List.generate(10, (index) {
                  return Container(
                      height: 10,
                      width: 10,
                      child: CardDish(
                        onPressed: () => context.go(AppPath.mealdetail),
                      ));
                }),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                // crossAxisSpacing: 10.0,
                // mainAxisSpacing: 10.0,
                childAspectRatio: 95 / 100,
                children: List.generate(10, (index) {
                  return Container(
                      height: 10,
                      width: 10,
                      child: CardDish(
                        onPressed: () => context.go(AppPath.mealdetail),
                      ));
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//   ／))      /)／)
//  (・   )o  (・   )o