import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class CardDish extends StatefulWidget {
  final Function? onPressed;
  final String nameMeal;
  final int priceMeal;
  final String mealId;
  final String imgUrl;
  final String kitchenName;

  const CardDish({
    super.key,
    required this.nameMeal,
    required this.priceMeal,
    this.onPressed,
    required this.mealId,
    required this.imgUrl,
    required this.kitchenName,
  });

  @override
  State<CardDish> createState() => _CardDishState();
}

class _CardDishState extends State<CardDish> {
  String nameMeal = '';
  int priceMeal = 0;
  String mealId = '';
  String imgUrl = '';
  String kitchenName = '';
  @override
  void initState() {
    super.initState();
    nameMeal = widget.nameMeal;
    priceMeal = widget.priceMeal;
    mealId = widget.mealId;
    imgUrl = widget.imgUrl;
    kitchenName = widget.kitchenName;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: TextButton(
        onPressed: () => widget.onPressed!(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Container(
          // color: Colors.red,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 120,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        truncateText(nameMeal, 18),
                        style: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      Text(kitchenName,
                          style: const TextStyle(color: Colors.grey)),
                      Row(
                        children: [
                          const Text(
                            'VND ',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(priceMeal.toString()),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  // height: 100,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(
                        getStorageUrl(imgUrl),
                        fit: BoxFit.cover,
                        height: 100,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
