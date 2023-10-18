import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../../utils/palette.dart';
import '../widgets/base_date_picker.dart';
import '../widgets/button_orange.dart';
import '../widgets/card_dish.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: Container(
            alignment: Alignment.centerLeft,
            child: TextField(
              controller: _searchTextController,
              decoration: InputDecoration(
                hintText: 'Search',
                fillColor: const Color(0xddddddFF),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                // conteprefixIconntPadding: EdgeInsets.only(right: 50),
                // prefixIconConstraints: BoxConstraints(
                //   minWidth: 80,
                // ),
                prefixIcon: GestureDetector(
                  onTap: () {
                    if (_searchTextController.text.isEmpty) {
                      return;
                    }
                    context
                        .go('${AppPath.search}/${_searchTextController.text}');
                  },
                  child: const Icon(Icons.search),
                ),
                suffixIcon: _searchTextController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchTextController.clear();
                        },
                        icon: const Icon(Icons.cancel))
                    : const SizedBox.shrink(),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () => context.go(AppPath.orderdetail),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xddddddFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.airplane_ticket_outlined,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () => context.go(AppPath.notification),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xddddddFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_none_sharp,
                  ),
                ),
              ),
            )
          ],
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "KHU VỰC HIỆN TẠI",
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text("Nhà Bè Hà Lan",
                              style: TextStyle(color: Color(0xFF676767))),
                          Icon(Icons.arrow_drop_down)
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    child: ButtonOrange(
                        title: "Xem bản đồ",
                        icon: Icons.location_on,
                        onPressed: () => context.go(AppPath.kitchenmap)),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Image.asset("assets/images/googlemap_illustrator.png")),
            Container(
              width: 100,
              height: 100,
              child: BaseDatePicker(
                restorationId: 'main',
              ),
            ),
            const ListTile(
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
            const ListTile(
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
            const ListTile(
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
