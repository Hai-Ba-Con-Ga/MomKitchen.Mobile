// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:go_router/go_router.dart';

// import '../../router/router.dart';
// import '../widgets/button_orange.dart';
// import '../widgets/card_dish.dart';
// import '../widgets/home/home.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();
//     loadMealData();
//   }

//   Future<void> loadMealData() async {
//     // final userData = await _userApi.getUserInfo();
//     // setState(() {
//     //   fullName = userData!.fullName;
//     //   email = userData.email;
//     //   phone = userData.phone;
//     //   avatarUrl = userData.avatarUrl;
//     //   birthday = userData.birthday;
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 100,
//           surfaceTintColor: Colors.white,
//           centerTitle: true,
//           title: Container(
//             alignment: Alignment.centerLeft,
//             child: Stack(children: [
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search',
//                   fillColor: const Color(0xddddddFF),
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(15),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                   // conteprefixIconntPadding: EdgeInsets.only(right: 50),
//                   // prefixIconConstraints: BoxConstraints(
//                   //   minWidth: 80,
//                   // ),
//                   prefixIcon: GestureDetector(
//                     onTap: () => context.go(AppPath.search),
//                     child: const Icon(Icons.search),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 right: 10,
//                 child: IconButton(
//                     onPressed: () {}, icon: const Icon(Icons.cancel)),
//               )
//             ]),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: InkWell(
//                 onTap: () => context.go(AppPath.orderdetail),
//                 child: Container(
//                   height: 40,
//                   width: 40,
//                   decoration: const BoxDecoration(
//                     color: Color(0xddddddFF),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.airplane_ticket_outlined,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: InkWell(
//                 onTap: () => context.go(AppPath.notification),
//                 child: Container(
//                   height: 40,
//                   width: 40,
//                   decoration: const BoxDecoration(
//                     color: Color(0xddddddFF),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.notifications_none_sharp,
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//         body: ListView(
//           children: [
//             ButtonOrange(
//               title: 'My Orders',
//               icon: Icons.assignment,
//               onPressed: () => context.go(AppPath.orderdetail),
//             ),
//             ButtonOrange(
//                 title: 'Select Location',
//                 icon: Icons.location_on,
//                 onPressed: () => context.go(AppPath.kitchenmap)),
//             const ListTile(
//               title: Text("Recent Kitchen"),
//             ),
//             Container(
//               height: 200,
//               width: double.infinity,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return CardDish(
//                     onPressed: () => context.go(AppPath.mealdetail), nameMeal: '', priceMeal: null,
//                   );
//                 },
//               ),
//             ),
//             const ListTile(
//               title: Text("Top Trending"),
//             ),
//             Container(
//               height: 200,
//               width: double.infinity,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return CardDish(
//                     onPressed: () => context.go(AppPath.mealdetail),
//                   );
//                 },
//               ),
//             ),
//             const ListTile(
//               title: Text("Favorite kitchen"),
//             ),
//             Container(
//               height: 200,
//               width: double.infinity,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return CardDish(
//                     onPressed: () => context.go(AppPath.mealdetail),
//                   );
//                 },
//               ),
//             ),
//             // ListDish(title: 'Recent kitchen'),
//             // ListDish(title: 'Favorite kitchen'),
//             // ListDish(title: 'Top Trending kitchen'),
//           ],
//         ));
//   }
// }
