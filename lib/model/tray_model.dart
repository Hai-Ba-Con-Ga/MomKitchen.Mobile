import 'dart:convert';

import 'dish_model.dart';

class Tray {
  String? id;
  int? no;
  String? name;
  String? description;
  String? imgUrl;
  int? price;
  String? kitchenId;
  String? kitchenName;
  List<Dish>? dish;
  DateTime? createdDate;

  Tray({
    this.id,
    this.no,
    this.name,
    this.description,
    this.imgUrl,
    this.price,
    this.kitchenId,
    this.kitchenName,
    this.dish,
    this.createdDate,
  });

  factory Tray.fromRawJson(String str) => Tray.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tray.fromJson(Map<String, dynamic> json) => Tray(
        id: json["id"],
        no: json["no"],
        name: json["name"],
        description: json["description"],
        imgUrl: json["imgUrl"],
        price: json["price"],
        kitchenId: json["kitchenId"],
        kitchenName: json["kitchenName"],
        dish: json["dish"] == null ? [] : List<Dish>.from(json["dish"]!.map((x) => Dish.fromJson(x))),
        createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no": no,
        "name": name,
        "description": description,
        "imgUrl": imgUrl,
        "price": price,
        "kitchenId": kitchenId,
        "kitchenName": kitchenName,
        "dish": dish == null ? [] : List<dynamic>.from(dish!.map((x) => x.toJson())),
        "createdDate": createdDate?.toIso8601String(),
      };
}

class TrayCreateRequest {
  String? name;
  String? description;
  String? imgUrl;
  int? price;
  String? kitchenId;
  List<String>? dishIds;

  TrayCreateRequest({
    this.name,
    this.description,
    this.imgUrl,
    this.price,
    this.kitchenId,
    this.dishIds,
  });

  factory TrayCreateRequest.fromRawJson(String str) => TrayCreateRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TrayCreateRequest.fromJson(Map<String, dynamic> json) => TrayCreateRequest(
        name: json["name"],
        description: json["description"],
        imgUrl: json["imgUrl"],
        price: json["price"],
        kitchenId: json["kitchenId"],
        dishIds: json["dishIds"] == null ? [] : List<String>.from(json["dishIds"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "imgUrl": imgUrl,
        "price": price,
        "kitchenId": kitchenId,
        "dishIds": dishIds == null ? [] : List<dynamic>.from(dishIds!.map((x) => x)),
      };
}
