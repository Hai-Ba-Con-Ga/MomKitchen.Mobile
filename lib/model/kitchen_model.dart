import 'dart:convert';

class KitchenRequest {
  String name;
  String address;
  String status;
  Location location;
  String ownerId;
  String areaId;

  KitchenRequest({
    required this.name,
    required this.address,
    required this.status,
    required this.location,
    required this.ownerId,
    required this.areaId,
  });

  factory KitchenRequest.fromRawJson(String str) => KitchenRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KitchenRequest.fromJson(Map<String, dynamic> json) => KitchenRequest(
        name: json["name"],
        address: json["address"],
        status: json["status"],
        location: Location.fromJson(json["location"]),
        ownerId: json["ownerId"],
        areaId: json["areaId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "status": status,
        "location": location.toJson(),
        "ownerId": ownerId,
        "areaId": areaId,
      };
}

class Location {
  int lat;
  int lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
