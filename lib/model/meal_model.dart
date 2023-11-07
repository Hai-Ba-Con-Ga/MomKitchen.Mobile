import 'dart:convert';

import 'kitchen_model.dart';
import 'tray_model.dart';

class MealGetAllResponse {
  String? id;
  int? no;
  String? name;
  int? price;
  DateTime serviceFrom;
  DateTime serviceTo;
  int? serviceQuantity;
  DateTime? closeTime;
  Kitchen? kitchen;
  Tray? tray;

  MealGetAllResponse({
    required this.id,
    required this.no,
    required this.name,
    required this.price,
    required this.serviceFrom,
    required this.serviceTo,
    required this.serviceQuantity,
    required this.closeTime,
    required this.kitchen,
    required this.tray,
  });

  factory MealGetAllResponse.fromRawJson(String str) =>
      MealGetAllResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MealGetAllResponse.fromJson(Map<String, dynamic> json) =>
      MealGetAllResponse(
        id: json['id'],
        no: json['no'],
        name: json['name'],
        price: json['price'].toInt(),
        serviceFrom: DateTime.parse(json['serviceFrom']),
        serviceTo: DateTime.parse(json['serviceTo']),
        serviceQuantity: json['serviceQuantity'],
        closeTime: json['close_time'] == null
            ? null
            : DateTime.parse(json['close_time']),
        kitchen:
            json['kitchen'] == null ? null : Kitchen.fromJson(json['kitchen']),
        tray: json['tray'] == null ? null : Tray.fromJson(json['tray']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no': no,
        'name': name,
        'price': price,
        'serviceFrom': serviceFrom?.toIso8601String(),
        'serviceTo': serviceTo?.toIso8601String(),
        'serviceQuantity': serviceQuantity,
        'close_time': closeTime?.toIso8601String(),
        'kitchen': kitchen?.toJson(),
        'tray': tray?.toJson(),
      };
}

class MealCreateRequest {
  String? name;
  int? price;
  DateTime? serviceFrom;
  DateTime? serviceTo;
  int? serviceQuantity;
  DateTime? closeTime;
  String? trayId;
  String? kitchenId;

  MealCreateRequest({
    this.name,
    this.price,
    this.serviceFrom,
    this.serviceTo,
    this.serviceQuantity,
    this.closeTime,
    this.trayId,
    this.kitchenId,
  });

  factory MealCreateRequest.fromRawJson(String str) =>
      MealCreateRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MealCreateRequest.fromJson(Map<String, dynamic> json) =>
      MealCreateRequest(
        name: json['name'],
        price: json['price'].toInt(),
        serviceFrom: json['serviceFrom'] == null
            ? null
            : DateTime.parse(json['serviceFrom']),
        serviceTo: json['serviceTo'] == null
            ? null
            : DateTime.parse(json['serviceTo']),
        serviceQuantity: json['serviceQuantity'],
        closeTime: json['closeTime'] == null
            ? null
            : DateTime.parse(json['closeTime']),
        trayId: json['trayId'],
        kitchenId: json['kitchenId'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'serviceFrom': serviceFrom?.toIso8601String(),
        'serviceTo': serviceTo?.toIso8601String(),
        'serviceQuantity': serviceQuantity,
        'closeTime': closeTime?.toIso8601String(),
        'trayId': trayId,
        'kitchenId': kitchenId,
      };
}
