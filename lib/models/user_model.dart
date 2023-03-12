import 'dart:convert';

import 'package:chance_dart/chance_dart.dart' as chance;
import 'package:equatable/equatable.dart';
import 'package:frog_start/utils/crypt_util.dart';
import 'package:uuid/uuid.dart';

// ignore_for_file: public_member_api_docs

class UserModel extends Equatable {
  final String id;
  final String email;
  final String phone;
  final String gender;
  final String country;
  final String password;

  const UserModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.gender,
    required this.country,
    required this.password,
  });

  factory UserModel.random() {
    return UserModel(
      id: const Uuid().v4(),
      email: '${chance.firstName()}@gmail.com',
      phone: chance.phone(),
      gender: chance.gender(),
      country: chance.country().name!,
      password: CryptUtil.hashPassword('123456'),
    );
  }

  factory UserModel.initial(Map<String, dynamic> map) {
    return UserModel(
      id: chance.generateUUID(),
      email: map['email'],
      phone: map['phone'],
      gender: map['gender'],
      country: map['country'],
      password: CryptUtil.hashPassword(map['password']),
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

  Map<String, dynamic> toSecureMap() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'gender': gender,
      'country': country,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      country: map['country'] ?? '',
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      id,
      email,
      phone,
      gender,
      country,
    ];
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? phone,
    String? gender,
    String? country,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      password: password,
    );
  }
}
