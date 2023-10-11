import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../widgets/button_back.dart';
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
        // backgroundColor: Colors.orange,
        toolbarHeight: 100,
        centerTitle: true,
        leadingWidth: 50,
        // backgroundColor: Colors.orange,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
              onTap: () => context.go(AppPath.home),
              child: Container(
                  // margin: EdgeInsets.all(0),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xF6F6F6FF),
                    // color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.chevron_left_sharp,
                  ))),
        ),
        title: Container(
          alignment: Alignment.centerLeft,
          // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Stack(children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                fillColor: Color(0xF6F6F6FF),
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
            // color: Colors.blue,
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
      body: Container(
        height: 1000,
        color: Colors.orange,
        child: ListView(
          children: [
            Column(
              children: [
                ListTile(
                  title: Text("Danh mục"),
                ),
                ListTag(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
