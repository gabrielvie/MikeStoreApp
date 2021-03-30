import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  String id;
  String email;
  String password;
  List<String> favorites;

  User({
    @required this.id,
    @required this.email,
    this.password,
    this.favorites,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'favorites': favorites,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      favorites: map.containsKey('avorites')
          ? List<String>.from(map['favorites'])
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, email: $email, password: $password, favorites: $favorites)';
  }
}
