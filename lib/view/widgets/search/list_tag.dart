import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../tag_card.dart';

class ListTag extends StatefulWidget {
  const ListTag({super.key, this.title});
  final String? title;

  @override
  State<ListTag> createState() => _ListTagState();
}

class _ListTagState extends State<ListTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Card(
              child: TagCard(),
            );
          },
          itemCount: 10),
    );
  }
}
