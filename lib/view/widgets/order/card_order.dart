import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../../router/router.dart';
import '../base_ListTile.dart';

// class CardOrder extends StatefulWidget {
//   const CardOrder({super.key});

//   @override
//   State<CardOrder> createState() => _CardOrderState();
// }

// class _CardOrderState extends State<CardOrder> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//       child: ListTile(
//         onTap: () {
//           Logger().i('hehe');
//         },
//         // isThreeLine: true,
//         tileColor: const Color(0xFFECF0F4),
//         leading: const Icon(Icons.radio_button_unchecked_sharp),
//         // trailing: Icon(Icons.radio_button_unchecked_sharp),
//         title: Row(
//           children: [
//             // const SizedBox(width: 5),
//             Text('Name of Meal'),
//           ],
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Name of Kitchen'),
//             Text('Time of Meal'),
//           ],
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//       ),
//     );
//   }
// }

class CardOrder extends StatefulWidget {
  const CardOrder({super.key});

  @override
  State<CardOrder> createState() => _CardOrderState();
}

class _CardOrderState extends State<CardOrder> {
  @override
  Widget build(BuildContext context) {
    return BaseListTile(
      onPressed: () {
        context.push(AppPath.orderdetail);
      },
      icon: const Icon(Icons.receipt_long_outlined, color: Colors.red),
      title: const Text('Bữa tối thứ 6', style: TextStyle(fontSize: 20)),
      description: const Text(
        'Bếp của My',
        style: TextStyle(color: Color.fromRGBO(50, 52, 62, 1)),
      ),
      // time: Text(formattedDate),
      time: Text('6-11-2023'),
    );
  }
}
