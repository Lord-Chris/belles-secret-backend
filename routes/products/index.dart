import 'package:dart_frog/dart_frog.dart';
import 'package:frog_start/models/app_response.dart';
import 'package:frog_start/models/product_model.dart';

Response onRequest(RequestContext context) {
  final request = context.request;
  final params = request.uri.queryParameters;
  final query = params['q'];
  late List<ProductModel> products;

  if (query != null) {
    products = (productList..shuffle())
        .where(
          (product) => product.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  } else {
    products = (productList..shuffle()).take(15).toList();
  }

  return Response.json(
    body: AppResponse.success(
      data: {
        'products': products.map((e) => e.toMap()).toList(),
      },
    ).toMap(),
  );
}
