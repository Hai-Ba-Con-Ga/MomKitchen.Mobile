import 'package:flutter/material.dart';

class CardDish extends StatefulWidget {
  const CardDish({super.key, this.onPressed});
  final Function? onPressed;

  @override
  State<CardDish> createState() => _CardDishState();
}

class _CardDishState extends State<CardDish> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
      // color: Colors.blue,
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
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cafenio Restaurant',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      Text('Buffalo Burgers',
                          style: TextStyle(color: Colors.grey)),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: Colors.orange),
                          Text("1.9km"),
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
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(
                        "https://cdn.britannica.com/36/123536-050-95CB0C6E/Variety-fruits-vegetables.jpg",
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
