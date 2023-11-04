import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../widgets/button_back.dart';
import '../widgets/card_dish.dart';
import '../widgets/search/search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.searchText});
  final String? searchText;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(() {
      setState(() {});
    });
    _searchTextController.text = widget.searchText ?? '';
  }

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
                  decoration: const BoxDecoration(
                    color: Color(0xddddddFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_left_sharp,
                  ))),
        ),
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
                  context.go('${AppPath.search}/${_searchTextController.text}');
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Container(
            height: 40,
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Bán chạy   |   Gần đây   |   Giá <> '),
                  Image.asset(
                    'assets/images/Filter.png',
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
              title: const Text('List Meal'),
              floating: true,
              // expandedHeight: 200.0,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                // crossAxisSpacing: 10.0,
                // mainAxisSpacing: 10.0,
                childAspectRatio: 95 / 100,
                children: List.generate(10, (index) {
                  return Container(
                      height: 10, width: 10, child: const Text('hehe'));
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