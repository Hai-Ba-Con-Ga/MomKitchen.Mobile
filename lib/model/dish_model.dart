import 'dart:convert';

class Dish {
  String? id;
  int? no;
  String? name;
  String? imageUrl;
  String? description;
  String? kitchenId;

  Dish({
    this.id,
    this.no,
    this.name,
    this.imageUrl,
    this.description,
    this.kitchenId,
  });

  factory Dish.fromRawJson(String str) => Dish.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        id: json["id"],
        no: json["no"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        description: json["description"],
        kitchenId: json["kitchenId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no": no,
        "name": name,
        "imageUrl": imageUrl,
        "description": description,
        "kitchenId": kitchenId,
      };
}

class DishUpdateRequest {
  String? name;
  String? imageUrl;
  String? description;

  DishUpdateRequest({
    this.name,
    this.imageUrl,
    this.description,
  });

  factory DishUpdateRequest.fromRawJson(String str) => DishUpdateRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DishUpdateRequest.fromJson(Map<String, dynamic> json) => DishUpdateRequest(
        name: json["name"],
        imageUrl: json["imageUrl"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "description": description,
      };
}
