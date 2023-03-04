import 'package:dart_frog/dart_frog.dart';
import 'package:frog_start/models/app_response.dart';
import 'package:frog_start/models/collection_model.dart';

Response onRequest(RequestContext context) {
  return Response.json(
    body: AppResponse.success(
      data: {
        'collections':
            List.generate(10, (_) => CollectionModel.random().toMap())
      },
    ).toMap(),
  );
}
