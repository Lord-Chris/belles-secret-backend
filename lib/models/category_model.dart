import 'dart:convert';

import 'package:frog_start/constants.dart';
import 'package:uuid/uuid.dart';

// ignore_for_file: public_member_api_docs

class CategoryModel {
  final String id;
  final String name;

  CategoryModel({
    required this.id,
    required this.name,
  });
  factory CategoryModel.random() {
    return CategoryModel(
      id: const Uuid().v4(),
      name: AppConstants.randCategory,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));
}

final categoryList = List.generate(1000, (_) => CategoryModel.random());
