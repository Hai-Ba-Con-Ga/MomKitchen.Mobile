import 'dart:convert';

class Kitchen {
  int? no;
  String? id;
  String? name;
  String? address;
  String? imgUrl;
  String? status;

  Kitchen({
    required this.no,
    required this.id,
    required this.name,
    required this.address,
    required this.imgUrl,
    required this.status,
  });

  factory Kitchen.fromRawJson(String str) => Kitchen.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Kitchen.fromJson(Map<String, dynamic> json) => Kitchen(
        no: json['no'],
        id: json['id'],
        name: json['name'],
        address: json['address'],
        imgUrl: json['imgUrl'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'no': no,
        'id': id,
        'name': name,
        'address': address,
        'imgUrl': imgUrl,
        'status': status,
      };
}

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

  factory KitchenRequest.fromRawJson(String str) =>
      KitchenRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KitchenRequest.fromJson(Map<String, dynamic> json) => KitchenRequest(
        name: json['name'],
        address: json['address'],
        status: json['status'],
        location: Location.fromJson(json['location']),
        ownerId: json['ownerId'],
        areaId: json['areaId'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'status': status,
        'location': location.toJson(),
        'ownerId': ownerId,
        'areaId': areaId,
      };
}

class Location {
  int lat;
  int lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json['lat'],
        lng: json['lng'],
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };
}
