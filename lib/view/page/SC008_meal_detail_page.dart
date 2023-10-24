import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../widgets/button_orange.dart';

class MealDetail extends StatefulWidget {
  const MealDetail({super.key});

  @override
  State<MealDetail> createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        // backgroundColor: Color(0x44000000),
        elevation: 0,
        title: const Text('Title'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.heart_broken,
                color: Colors.red[600],
                size: 50,
              )),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            child: Image.network(
              'https://momkitchen.s3.ap-southeast-1.amazonaws.com/cc6a28fd-6d14-4f59-91a3-1a888ce00c15',
              height: 400,
              width: 500,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            width: 500,
            height: 1000,
            margin: const EdgeInsets.all(20),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Buoi Toi Sang Chanh Cua Mien Tay',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.end,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'tuu quan sinh vien',
                  style: TextStyle(
                    fontSize: 14,
                    // color: Color(0x181C2EFF),
                  ),
                  textAlign: TextAlign.end,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(Icons.star),
                    Text(' 4.7'),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(Icons.fire_truck_sharp),
                    Text(' Free'),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(Icons.timelapse_rounded),
                    Text(' 20 min'),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator.'),
                Text('FeedBack'),
              ],
            ),
          ),
        ],
      )),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(left: 20),
        child: ButtonOrange(
          onPressed: () => context.go(AppPath.order),
          title: 'ĐẶT NGAY NÈ',
        ),
      ),
    );
  }
}
