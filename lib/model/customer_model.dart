import 'dart:convert';

class Customer {
  int? no;
  String? id;
  String? status;
  String? userId;
  User? user;

  Customer({
    this.no,
    this.id,
    this.status,
    this.userId,
    this.user,
  });

  factory Customer.fromRawJson(String str) =>
      Customer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        no: json['no'],
        id: json['id'],
        status: json['status'],
        userId: json['userId'],
        user: json['user'] == null ? null : User.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        'no': no,
        'id': id,
        'status': status,
        'userId': userId,
        'user': user?.toJson(),
      };
}

class User {
  String? id;
  String? email;
  String? fullName;
  String? avatarUrl;
  String? phone;

  User({
    this.id,
    this.email,
    this.fullName,
    this.avatarUrl,
    this.phone,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        email: json['email'],
        fullName: json['fullName'],
        avatarUrl: json['avatarUrl'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'fullName': fullName,
        'avatarUrl': avatarUrl,
        'phone': phone,
      };
}
