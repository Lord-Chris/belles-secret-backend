import 'dart:convert';

import 'package:chance_dart/chance_dart.dart' as chance;

// ignore_for_file: public_member_api_docs

class UserModel {
  final String id;
  final String email;
  final String phone;
  final String gender;
  final String country;

  UserModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.gender,
    required this.country,
  });

  factory UserModel.random() {
    return UserModel(
      id: chance.generateUUID(),
      email: '${chance.firstName()}@gmail.com',
      phone: chance.phone(),
      gender: chance.gender(),
      country: chance.country(),
    );
  }

  factory UserModel.initial(Map<String, dynamic> map) {
    return UserModel(
      id: chance.generateUUID(),
      email: map['email'],
      phone: map['phone'],
      gender: map['gender'],
      country: map['country'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'gender': gender,
      'country': country,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      country: map['country'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
