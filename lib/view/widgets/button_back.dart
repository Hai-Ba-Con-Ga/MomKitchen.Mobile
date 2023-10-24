import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({super.key, this.onPressed});
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (onPressed != null) ? (onPressed as void Function()) : (() => context.pop()),
      child: Container(
        margin: const EdgeInsets.all(15),
        // width: 30.0,
        // height: 30.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFECF0F4),
          // color: Colors.black
        ),
        child: const Center(
          child: Icon(Icons.chevron_left_sharp),
        ),
      ),
    );
  }
}
