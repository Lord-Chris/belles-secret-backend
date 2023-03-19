import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:frog_start/constants.dart';
import 'package:frog_start/extensions/validator_extension.dart';
import 'package:frog_start/models/app_response.dart';
import 'package:frog_start/models/login_model.dart';
import 'package:frog_start/repositories/user_repository.dart';
import 'package:frog_start/utils/crypt_util.dart';
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
        return _methodNotAllowed();
    }
  } on Exception catch (e) {
    return Response.json(
      statusCode: HttpStatus.internalServerError,
      headers: context.request.headers,
      body: {'error': e.toString()},
    );
  }
}

Response _methodNotAllowed() {
  return Response.json(
    statusCode: HttpStatus.methodNotAllowed,
    body: {'error': 'Method not Allowed'},
  );
}

Future<Response> _post(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;

  if (body.isEmpty) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {'error': 'Email and password is missing'},
    );
  }

  final data = LoginModel.fromMap(body);
  if (context.validateEmail(data.email) != null) {
    return Response.json(
      statusCode: HttpStatus.unprocessableEntity,
      body: {'error': 'Invalid Email'},
    );
  }

  if (context.validatePassword(data.password) != null) {
    return Response.json(
      statusCode: HttpStatus.unprocessableEntity,
      body: {'error': context.validatePassword(data.password)},
    );
  }

  final user = context.read<UserRepository>().getUserByEmail(data.email);

  if (user == null || user.password != CryptUtil.hashPassword(data.password)) {
    return Response.json(
      statusCode: HttpStatus.notFound,
      body: AppResponse.error('Invalid Login Credentials').toMap(),
    );
  }

  return Response.json(
    body: AppResponse.success(
      data: {
        'token': TokenUtil.createToken(user.id, AppConstants.secretKey),
        'user': user.toMap(),
      },
    ).toMap(),
  );
}
