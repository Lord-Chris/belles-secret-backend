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
        return _methodNotAllowed(context);
    }
  } on Exception catch (e) {
    return AppRes.fail(
      headers: context.request.headers,
      data: {'error': e.toString()},
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
  late Map<String, dynamic> body;
  try {
    body = await context.request.json() as Map<String, dynamic>;
  } catch (e) {
    return AppRes.error(
      statusCode: HttpStatus.unsupportedMediaType,
      headers: context.request.headers,
      message: 'The request payload must be in JSON format',
    );
  }
  if (body.isEmpty) {
    return AppRes.error(
      headers: context.request.headers,
      message: 'Email and password is missing',
    );
  }

  final data = LoginModel.fromMap(body);
  if (context.validateEmail(data.email) != null) {
    return AppRes.error(
      statusCode: HttpStatus.unprocessableEntity,
      headers: context.request.headers,
      message: 'Invalid Email',
    );
  }

  if (context.validatePassword(data.password) != null) {
    return AppRes.error(
      statusCode: HttpStatus.unprocessableEntity,
      headers: context.request.headers,
      message: context.validatePassword(data.password),
    );
  }

  final user = context.read<UserRepository>().getUserByEmail(data.email);
  if (user == null) {
    return AppRes.error(
      statusCode: HttpStatus.notFound,
      headers: context.request.headers,
      message: 'No account exists with this account',
    );
  }

  if (user.password != CryptUtil.hashPassword(data.password)) {
    return AppRes.error(
      statusCode: HttpStatus.notFound,
      headers: context.request.headers,
      message: 'Invalid Login Credentials',
    );
  }

  return AppRes.success(
    headers: context.request.headers,
    data: {
      'token': TokenUtil.createToken(user.id, AppConstants.secretKey),
      'user': user.toMap(),
    },
  );
}
