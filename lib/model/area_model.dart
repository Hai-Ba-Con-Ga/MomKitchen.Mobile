// To parse this JSON data, do
//
//     final area = areaFromJson(jsonString);

import 'dart:convert';

Area areaFromJson(String str) => Area.fromJson(json.decode(str));

String areaToJson(Area data) => json.encode(data.toJson());

class Area {
  String name;
  List<Boundary> boundaries;

  Area({
    required this.name,
    required this.boundaries,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        name: json['name'],
        boundaries: List<Boundary>.from(
            json['boundaries'].map((x) => Boundary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'boundaries': List<dynamic>.from(boundaries.map((x) => x.toJson())),
      };
}

class Boundary {
  String id;
  double lat;
  double lng;

  Boundary({
    required this.id,
    required this.lat,
    required this.lng,
  });

  factory Boundary.fromJson(Map<String, dynamic> json) => Boundary(
        id: json['id'],
        lat: json['lat']?.toDouble(),
        lng: json['lng']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'lat': lat,
        'lng': lng,
      };
}
