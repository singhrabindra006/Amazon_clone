import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: (map['_id'] ?? map['id'] ?? '').toString(),
      name: (map['name'] ?? '').toString(),
      email: (map['email'] ?? '').toString(),
      password: (map['password'] ?? '').toString(),
      address: (map['address'] ?? '').toString(),
      type: (map['type'] ?? '').toString(),
      token: (map['token'] ?? '').toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(dynamic source) {
    if (source is String) {
      return User.fromMap(json.decode(source) as Map<String, dynamic>);
    }
    if (source is Map<String, dynamic>) {
      return User.fromMap(source);
    }
    if (source is Map) {
      return User.fromMap(Map<String, dynamic>.from(source));
    }
    throw ArgumentError('Invalid user data: $source');
  }
}
