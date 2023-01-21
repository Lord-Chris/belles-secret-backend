import 'package:dart_frog/dart_frog.dart';
import 'package:frog_start/models/collection_model.dart';
import 'package:frog_start/models/success_response.dart';

Response onRequest(RequestContext context) {
  return Response.json(
    body: AppResponse.success(
      data: {
        'collections':
            List.generate(10, (_) => CollectionModel.random().toMap())
      },
    ).toSuccessMap(),
  );
}
