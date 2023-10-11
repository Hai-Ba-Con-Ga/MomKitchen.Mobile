import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({super.key, this.onPressed});
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed as void Function()?,
      child: Container(
        margin: EdgeInsets.all(15),
        // width: 30.0,
        // height: 30.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xECF0F4FF),
          // color: Colors.black
        ),
        child: Center(
          child: Icon(Icons.chevron_left_sharp),
        ),
      ),
    );
  }
}
