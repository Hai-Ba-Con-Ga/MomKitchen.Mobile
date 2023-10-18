import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class ButtonOrangeBK extends StatefulWidget {
  const ButtonOrangeBK({super.key, this.title, this.icon, this.onPressed});
  final String? title;
  final IconData? icon;
  final Function? onPressed;

  @override
  State<ButtonOrangeBK> createState() => _ButtonOrangeBKState();
}

class _ButtonOrangeBKState extends State<ButtonOrangeBK> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        alignment: Alignment.center,
        height: 50,
        child: TextButton(
          onPressed: widget.onPressed as void Function()?,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                  color: primaryColor, width: 2), // Đặt màu viền và độ rộng
            )),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            minimumSize:
                MaterialStateProperty.all(const Size(double.infinity, 60)),
          ),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (widget.icon == null)
                    ? const SizedBox.shrink()
                    : Icon(widget.icon ?? null, color: primaryColor),
                SizedBox(
                  width: 5,
                ),
                Text(widget.title ?? '',
                    style: TextStyle(color: primaryColor, fontSize: 20)),
              ],
            ),
          ),
        ));
  }
}
