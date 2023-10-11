import 'package:flutter/material.dart';

class TagCard extends StatefulWidget {
  @override
  _TagCardState createState() => _TagCardState();
}

class _TagCardState extends State<TagCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      // elevation: 4.0, // Độ nổi thẻ
      child: Container(
        child: Center(
          child: Text(
            'haha',
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
