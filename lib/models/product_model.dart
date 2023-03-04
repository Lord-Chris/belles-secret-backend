// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:chance_dart/chance_dart.dart' as chance;
import 'package:frog_start/constants.dart';
import 'package:frog_start/extensions/string_extension.dart';
import 'package:frog_start/models/category_model.dart';
import 'package:frog_start/models/collection_model.dart';
import 'package:uuid/uuid.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.image,
    required this.collection,
    required this.price,
    this.discount,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      categoryId: map['category_id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      collection: CollectionModel.fromMap(map['collection']),
      price: map['price'] ?? 0,
      discount: map['discount'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      deletedAt:
          map['deleted_at'] != null ? DateTime.parse(map['deleted_at']) : null,
    );
  }

  factory ProductModel.random() {
    final timestamp = DateTime.now();
    return ProductModel(
      id: const Uuid().v4(),
      categoryId: categoryList[(chance.natural(max: categoryList.length))].id,
      name: '${chance.word().capitalize()} ${AppConstants.pSuffix}',
      image: AppConstants.mockImage,
      collection: collectionList[(chance.natural(max: collectionList.length))],
      price: chance.integer(max: 10000),
      discount: chance.boolean() ? null : chance.integer(max: 40),
      createdAt: timestamp,
      updatedAt: timestamp,
    );
  }

  final String id;
  final String categoryId;
  final String name;
  final String image;
  final CollectionModel collection;
  final int price;
  final int? discount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'name': name,
      'image': image,
      'collection': collection.toMap(),
      'price': price,
      'discount': discount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
}

final productList = List.generate(1000, (_) => ProductModel.random());
