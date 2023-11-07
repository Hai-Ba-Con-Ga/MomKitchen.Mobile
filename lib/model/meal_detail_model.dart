import 'dart:convert';

class MealDetailResponse {
  String id;
  int no;
  String name;
  int price;
  DateTime serviceFrom;
  DateTime serviceTo;
  int serviceQuantity;
  DateTime closeTime;
  Tray tray;
  Kitchen kitchen;
  List<dynamic> feedbacks;

  MealDetailResponse({
    required this.id,
    required this.no,
    required this.name,
    required this.price,
    required this.serviceFrom,
    required this.serviceTo,
    required this.serviceQuantity,
    required this.closeTime,
    required this.tray,
    required this.kitchen,
    required this.feedbacks,
  });

  factory MealDetailResponse.fromRawJson(String str) =>
      MealDetailResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MealDetailResponse.fromJson(Map<String, dynamic> json) =>
      MealDetailResponse(
        id: json['id'],
        no: json['no'],
        name: json['name'],
        price: json['price'].toInt(),
        serviceFrom: DateTime.parse(json['serviceFrom']),
        serviceTo: DateTime.parse(json['serviceTo']),
        serviceQuantity: json['serviceQuantity'],
        closeTime: DateTime.parse(json['closeTime']),
        tray: Tray.fromJson(json['tray']),
        kitchen: Kitchen.fromJson(json['kitchen']),
        feedbacks: List<dynamic>.from(json['feedbacks'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no': no,
        'name': name,
        'price': price,
        'serviceFrom': serviceFrom.toIso8601String(),
        'serviceTo': serviceTo.toIso8601String(),
        'serviceQuantity': serviceQuantity,
        'closeTime': closeTime.toIso8601String(),
        'tray': tray.toJson(),
        'kitchen': kitchen.toJson(),
        'feedbacks': List<dynamic>.from(feedbacks.map((x) => x)),
      };
}

class Kitchen {
  int no;
  String id;
  String name;
  String address;
  String status;

  Kitchen({
    required this.no,
    required this.id,
    required this.name,
    required this.address,
    required this.status,
  });

  factory Kitchen.fromRawJson(String str) => Kitchen.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Kitchen.fromJson(Map<String, dynamic> json) => Kitchen(
        no: json['no'],
        id: json['id'],
        name: json['name'],
        address: json['address'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'no': no,
        'id': id,
        'name': name,
        'address': address,
        'status': status,
      };
}

class Tray {
  String id;
  int no;
  String name;
  String description;
  String imgUrl;
  int price;
  String kitchenId;
  List<Dishy> dishies;
  DateTime createdDate;

  Tray({
    required this.id,
    required this.no,
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.price,
    required this.kitchenId,
    required this.dishies,
    required this.createdDate,
  });

  factory Tray.fromRawJson(String str) => Tray.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tray.fromJson(Map<String, dynamic> json) => Tray(
        id: json['id'],
        no: json['no'],
        name: json['name'],
        description: json['description'],
        imgUrl: json['imgUrl'],
        price: json['price'].toInt(),
        kitchenId: json['kitchenId'],
        dishies: List<Dishy>.from(json['dishies'].map((x) => Dishy.fromJson(x))),
        createdDate: DateTime.parse(json['createdDate']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no': no,
        'name': name,
        'description': description,
        'imgUrl': imgUrl,
        'price': price,
        'kitchenId': kitchenId,
        'dishies': List<dynamic>.from(dishies.map((x) => x.toJson())),
        'createdDate': createdDate.toIso8601String(),
      };
}

class Dishy {
  String id;
  int no;
  String name;
  String imageUrl;
  String description;
  String kitchenId;

  Dishy({
    required this.id,
    required this.no,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.kitchenId,
  });

  factory Dishy.fromRawJson(String str) => Dishy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dishy.fromJson(Map<String, dynamic> json) => Dishy(
        id: json['id'],
        no: json['no'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        description: json['description'],
        kitchenId: json['kitchenId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no': no,
        'name': name,
        'imageUrl': imageUrl,
        'description': description,
        'kitchenId': kitchenId,
      };
}
