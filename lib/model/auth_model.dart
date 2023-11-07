class ResponseUser {
  bool isFirstTime;
  String token;
  User user;

  ResponseUser({
    required this.isFirstTime,
    required this.token,
    required this.user,
  });

  factory ResponseUser.fromJson(Map<String, dynamic> json) {
    return ResponseUser(
      isFirstTime: json['isFirstTime'],
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  String id;
  String email;
  String fullName;
  String avatarUrl;
  String phone;
  dynamic birthday;
  String roleName;
  String? kitchenId;
  String? customerId;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.avatarUrl,
    required this.phone,
    required this.birthday,
    required this.roleName,
    this.kitchenId,
    this.customerId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      avatarUrl: json['avatarUrl'],
      phone: json['phone'],
      birthday: json['birthday'],
      roleName: json['roleName'],
      kitchenId: json['kitchenId'],
      customerId: json['customerId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'fullName': fullName,
        'avatarUrl': avatarUrl,
        'phone': phone,
        'birthday': birthday,
        'roleName': roleName,
        'kitchenId': kitchenId,
        'customerId': customerId,
      };
}
