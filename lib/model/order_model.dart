import 'dart:convert';

import 'customer_model.dart';
import 'meal_model.dart';

class Order {
  String? id;
  int? no;
  int? totalPrice;
  int? totalQuantity;
  int? surcharge;
  int? status;
  Customer? customer;
  MealGetAllResponse? meal;
  DateTime? createdDate;

  Order({
    this.id,
    this.no,
    this.totalPrice,
    this.totalQuantity,
    this.surcharge,
    this.status,
    this.customer,
    this.meal,
    this.createdDate,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        no: json['no'],
        totalPrice: json['totalPrice'],
        totalQuantity: json['totalQuantity'],
        surcharge: json['surcharge'],
        status: json['status'],
        customer: json['customer'] == null
            ? null
            : Customer.fromJson(json['customer']),
        meal: json['meal'] == null
            ? null
            : MealGetAllResponse.fromJson(json['meal']),
        createdDate: json['createdDate'] == null
            ? null
            : DateTime.parse(json['createdDate']),
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

// class Customer {
//   int? no;
//   String? id;
//   String? status;
//   String? userId;
//   User? user;

//   Customer({
//     this.no,
//     this.id,
//     this.status,
//     this.userId,
//     this.user,
//   });

//   factory Customer.fromRawJson(String str) =>
//       Customer.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Customer.fromJson(Map<String, dynamic> json) => Customer(
//         no: json['no'],
//         id: json['id'],
//         status: json['status'],
//         userId: json['userId'],
//         user: json['user'] == null ? null : User.fromJson(json['user']),
//       );

//   Map<String, dynamic> toJson() => {
//         'no': no,
//         'id': id,
//         'status': status,
//         'userId': userId,
//         'user': user?.toJson(),
//       };
// }

// class Meal {
//   String? id;
//   int? no;
//   String? name;
//   int? price;
//   DateTime? serviceFrom;
//   DateTime? serviceTo;
//   int? serviceQuantity;
//   DateTime? closeTime;
//   Kitchen? kitchen;
//   Tray? tray;

//   Meal({
//     this.id,
//     this.no,
//     this.name,
//     this.price,
//     this.serviceFrom,
//     this.serviceTo,
//     this.serviceQuantity,
//     this.closeTime,
//     this.kitchen,
//     this.tray,
//   });

//   factory Meal.fromRawJson(String str) => Meal.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Meal.fromJson(Map<String, dynamic> json) => Meal(
//         id: json["id"],
//         no: json["no"],
//         name: json["name"],
//         price: json["price"],
//         serviceFrom: json["serviceFrom"] == null
//             ? null
//             : DateTime.parse(json["serviceFrom"]),
//         serviceTo: json["serviceTo"] == null
//             ? null
//             : DateTime.parse(json["serviceTo"]),
//         serviceQuantity: json["serviceQuantity"],
//         closeTime: json["close_time"] == null
//             ? null
//             : DateTime.parse(json["close_time"]),
//         kitchen:
//             json["kitchen"] == null ? null : Kitchen.fromJson(json["kitchen"]),
//         tray: json["tray"] == null ? null : Tray.fromJson(json["tray"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "no": no,
//         "name": name,
//         "price": price,
//         "serviceFrom": serviceFrom?.toIso8601String(),
//         "serviceTo": serviceTo?.toIso8601String(),
//         "serviceQuantity": serviceQuantity,
//         "close_time": closeTime?.toIso8601String(),
//         "kitchen": kitchen?.toJson(),
//         "tray": tray?.toJson(),
//       };
// }

// class Kitchen {
//   int? no;
//   String? id;
//   String? name;
//   String? address;
//   String? status;

//   Kitchen({
//     this.no,
//     this.id,
//     this.name,
//     this.address,
//     this.status,
//   });

//   factory Kitchen.fromRawJson(String str) => Kitchen.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Kitchen.fromJson(Map<String, dynamic> json) => Kitchen(
//         no: json['no'],
//         id: json['id'],
//         name: json['name'],
//         address: json['address'],
//         status: json['status'],
//       );

//   Map<String, dynamic> toJson() => {
//         'no': no,
//         'id': id,
//         'name': name,
//         'address': address,
//         'status': status,
//       };
// }

// class Tray {
//   String? id;
//   String? name;
//   String? description;
//   String? imgUrl;
//   int? price;

//   Tray({
//     this.id,
//     this.name,
//     this.description,
//     this.imgUrl,
//     this.price,
//   });

//   factory Tray.fromRawJson(String str) => Tray.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Tray.fromJson(Map<String, dynamic> json) => Tray(
//         id: json["id"],
//         name: json["name"],
//         description: json["description"],
//         imgUrl: json["imgUrl"],
//         price: json["price"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "description": description,
//         "imgUrl": imgUrl,
//         "price": price,
//       };
// }
