import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../model/order_model.dart';
import '../../../router/router.dart';
import '../../../utils/utils.dart';
import '../base_ListTile.dart';

class CardOrderKitchen extends StatefulWidget {
  const CardOrderKitchen({super.key, required this.order});
  final Order order;
  @override
  State<CardOrderKitchen> createState() => _CardOrderKitchenState();
}

class _CardOrderKitchenState extends State<CardOrderKitchen> {
  @override
  Widget build(BuildContext context) {
    var serviceFrom = DateFormat('yyyy-MM-dd – kk:mm').format(widget.order.meal.serviceFrom);
    return BaseListTile(
      onPressed: () {
        context.push('${AppPath.orderdetail}/${widget.order.id}');
      },
      icon: const Icon(Icons.receipt_long_outlined, color: Colors.red),
      title: Text(truncateText(widget.order.meal.name ?? 'Không có tên', 23) + '\n' + truncateText(widget.order.customer.user?.fullName ?? '', 23), style: const TextStyle(fontSize: 20)),
      description: Text(
        'Số lượng: ${widget.order.totalQuantity}' ?? 'Không có tên bếp',
        style: TextStyle(color: Color.fromRGBO(50, 52, 62, 1)),
      ),
      time: Text('Bắt đầu từ: $serviceFrom'),
      trailing: Container(
        color: widget.order.status == 'PAID' ? Colors.yellow : (widget.order.status == 'COMPLETED' ? Colors.green : Colors.red),
        child: Text('${widget.order.status}'),
      ),
    );
  }
}
