import 'dart:convert';

class MealGetReponse {
  String? id;
  int? no;
  String? name;
  int? price;
  DateTime? serviceFrom;
  DateTime? serviceTo;
  int? serviceQuantity;
  DateTime? closeTime;

  MealGetReponse({
    this.id,
    this.no,
    this.name,
    this.price,
    this.serviceFrom,
    this.serviceTo,
    this.serviceQuantity,
    this.closeTime,
  });

  factory MealGetReponse.fromRawJson(String str) => MealGetReponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MealGetReponse.fromJson(Map<String, dynamic> json) => MealGetReponse(
        id: json["id"],
        no: json["no"],
        name: json["name"],
        price: json["price"],
        serviceFrom: json["serviceFrom"] == null ? null : DateTime.parse(json["serviceFrom"]),
        serviceTo: json["serviceTo"] == null ? null : DateTime.parse(json["serviceTo"]),
        serviceQuantity: json["serviceQuantity"],
        closeTime: json["close_time"] == null ? null : DateTime.parse(json["close_time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no": no,
        "name": name,
        "price": price,
        "serviceFrom": serviceFrom?.toIso8601String(),
        "serviceTo": serviceTo?.toIso8601String(),
        "serviceQuantity": serviceQuantity,
        "close_time": closeTime?.toIso8601String(),
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

  factory MealCreateRequest.fromRawJson(String str) => MealCreateRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MealCreateRequest.fromJson(Map<String, dynamic> json) => MealCreateRequest(
        name: json["name"],
        price: json["price"],
        serviceFrom: json["serviceFrom"] == null ? null : DateTime.parse(json["serviceFrom"]),
        serviceTo: json["serviceTo"] == null ? null : DateTime.parse(json["serviceTo"]),
        serviceQuantity: json["serviceQuantity"],
        closeTime: json["closeTime"] == null ? null : DateTime.parse(json["closeTime"]),
        trayId: json["trayId"],
        kitchenId: json["kitchenId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "serviceFrom": serviceFrom?.toIso8601String(),
        "serviceTo": serviceTo?.toIso8601String(),
        "serviceQuantity": serviceQuantity,
        "closeTime": closeTime?.toIso8601String(),
        "trayId": trayId,
        "kitchenId": kitchenId,
      };
}
