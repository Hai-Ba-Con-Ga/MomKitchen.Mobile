import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ButtonHomePage extends StatefulWidget {
  const ButtonHomePage({Key? key, this.title, this.icon}) : super(key: key);
  final String? title;
  final IconData? icon;

  @override
  State<ButtonHomePage> createState() => _ButtonHomePageState();
}

class _ButtonHomePageState extends State<ButtonHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        width: 10,
        height: 50,
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(widget.icon ?? Icons.numbers, color: Colors.white),
              SizedBox(width: 10),
              Text(widget.title ?? 'Null Title',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
        ));
  }
}
