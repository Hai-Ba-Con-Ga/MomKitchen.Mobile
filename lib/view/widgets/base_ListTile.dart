import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';

class BaseListTile extends StatefulWidget {
  const BaseListTile({
    super.key,
    this.icon,
    this.title,
    this.description,
    this.time,
    this.trailing,
    this.onPressed,
  });
  final Icon? icon;
  final Text? title;
  final Text? description;
  final Text? time;
  final Widget? trailing;
  final Function? onPressed;

  @override
  State<BaseListTile> createState() => _BaseListTileState();
}

class _BaseListTileState extends State<BaseListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: ListTile(
        isThreeLine: true,
        tileColor: const Color(0xFFECF0F4),
        leading: widget.icon ?? const SizedBox.shrink(),
        trailing: widget.trailing ?? const Icon(Icons.more_vert),
        title: Row(
          children: [
            const SizedBox(width: 5),
            widget.title ?? const SizedBox.shrink(),
          ],
        ),
        subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          widget.description ?? const SizedBox.shrink(),
          const SizedBox(height: 5),
          widget.time ?? const SizedBox.shrink(),
        ]),
        onTap: () {
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      ),
    );
  }
}
