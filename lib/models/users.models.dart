import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String token;
  final String type;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.token,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'token': token,
      'type': type,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      token: map['token'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? token,
    String? type,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      token: token ?? this.token,
      type: type ?? this.type,
    );
  }
}
