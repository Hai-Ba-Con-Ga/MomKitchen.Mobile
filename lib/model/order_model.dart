import 'dart:convert';

import 'customer_model.dart';
import 'meal_model.dart';

class Order {
  String id;
  int no;
  int totalPrice;
  int totalQuantity;
  int surcharge;
  String status;
  Customer customer;
  MealGetAllResponse meal;
  DateTime createdDate;

  Order({
    required this.id,
    required this.no,
    required this.totalPrice,
    required this.totalQuantity,
    required this.surcharge,
    required this.status,
    required this.customer,
    required this.meal,
    required this.createdDate,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        no: json['no'],
        totalPrice: json['totalPrice'].toInt(),
        totalQuantity: json['totalQuantity'],
        surcharge: json['surcharge'].toInt(),
        status: json['status'].toString(),
        customer: Customer.fromJson(json['customer']),
        meal: MealGetAllResponse.fromJson(json['meal']),
        createdDate: DateTime.parse(json['createdDate']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no': no,
        'totalPrice': totalPrice,
        'totalQuantity': totalQuantity,
        'surcharge': surcharge,
        'status': status,
        'customer': customer?.toJson(),
        'meal': meal?.toJson(),
        'createdDate': createdDate?.toIso8601String(),
      };
}
