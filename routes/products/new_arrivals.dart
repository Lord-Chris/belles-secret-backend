import 'package:dart_frog/dart_frog.dart';
import 'package:frog_start/models/app_response.dart';
import 'package:frog_start/models/collection_model.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.collection,
    required this.price,
    this.discount,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  final String id;
  final String categoryId;
  final String name;
  final CollectionModel collection;
  final int price;
  final int? discount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
}

Response onRequest(RequestContext context) {
  return Response.json(body: AppResponse.success(data: {}).toMap());
}
