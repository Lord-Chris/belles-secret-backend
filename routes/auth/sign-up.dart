import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:frog_start/constants.dart';
import 'package:frog_start/models/app_response.dart';
import 'package:frog_start/models/user_model.dart';
import 'package:frog_start/repositories/user_repository.dart';
import 'package:frog_start/utils/token_util.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    switch (context.request.method) {
      case HttpMethod.post:
        return _post(context);
      case HttpMethod.delete:
      case HttpMethod.get:
      case HttpMethod.head:
      case HttpMethod.options:
      case HttpMethod.patch:
      case HttpMethod.put:
        return _methodNotAllowed(context);
    }
  } on Exception {
    return AppRes.fail(
      statusCode: HttpStatus.internalServerError,
      headers: context.request.headers,
    );
  }
}

Response _methodNotAllowed(RequestContext context) {
  return AppRes.error(
    statusCode: HttpStatus.methodNotAllowed,
    headers: context.request.headers,
    message: 'Method not Allowed',
  );
}

Future<Response> _post(RequestContext context) async {
  final body = await context.request.json();
  final user = UserModel.initial(body);

  context.read<UserRepository>().createUser(user);

  return Response.json(
    body: AppResponse.success(
      data: {
        'token': TokenUtil.createToken(user.id, AppConstants.secretKey),
        'user': user.toMap(),
      },
    ).toMap(),
  );
}
