import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ButtonOrange extends StatefulWidget {
  const ButtonOrange({super.key, this.title, this.icon, this.onPressed});
  final String? title;
  final IconData? icon;
  final Function? onPressed;

  @override
  State<ButtonOrange> createState() => _ButtonOrangeState();
}

class _ButtonOrangeState extends State<ButtonOrange> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        alignment: Alignment.center,
        height: 50,
        child: TextButton(
          onPressed: widget.onPressed as void Function()?,
          style: ButtonStyle(
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
                    : Icon(widget.icon ?? null, color: Colors.white),
                Text(widget.title ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
          ),
        ));
  }
}
