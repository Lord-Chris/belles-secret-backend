// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:chance_dart/chance_dart.dart' as chance;
import 'package:frog_start/constants.dart';
import 'package:frog_start/extensions/string_extension.dart';
import 'package:uuid/uuid.dart';

class CollectionModel {
  const CollectionModel({
    required this.id,
    required this.name,
    required this.cover,
    this.discount,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory CollectionModel.random() {
    final timestamp = DateTime.now();
    return CollectionModel(
      id: const Uuid().v4(),
      name: '${chance.word().capitalize()} ${AppConstants.cSuffix}',
      cover: AppConstants.mockImage,
      createdAt: timestamp,
      updatedAt: timestamp,
    );
  }

  factory CollectionModel.fromJson(String source) =>
      CollectionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CollectionModel.fromMap(Map<String, dynamic> map) {
    return CollectionModel(
      id: map['id'] as String,
      name: map['name'] as String,
      cover: map['cover'] as String,
      discount: map['discount'] as double,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      deletedAt: map['deleted_at'] != null
          ? DateTime.parse(map['deleted_at'] as String)
          : null,
    );
  }

  final String id;
  final String name;
  final String cover;
  final double? discount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cover': cover,
      'discount': discount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
}
