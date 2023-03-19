import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:frog_start/constants.dart';
import 'package:frog_start/extensions/validator_extension.dart';
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
  } catch (e) {
    return AppRes.fail(
      headers: context.request.headers,
      data: {'error': e.toString()},
    );
  }
}
// {
//     "email": "maduekechris65@gmail.com",
//     "phone": "080342342342",
//     "gender": "male",
//     "country": "Nigeria",
//     "password": "1234556"
// }

Response _methodNotAllowed(RequestContext context) {
  return AppRes.error(
    statusCode: HttpStatus.methodNotAllowed,
    headers: context.request.headers,
    message: 'Method not Allowed',
  );
}

Future<Response> _post(RequestContext context) async {
  try {
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

    final userRepo = context.read<UserRepository>();
    if (body.isEmpty) {
      return AppRes.error(
        headers: context.request.headers,
        message: 'Email and password is missing',
      );
    }
    final user = UserModel.initial(body);

    if (context.validateEmail(user.email) != null) {
      return AppRes.error(
        statusCode: HttpStatus.unprocessableEntity,
        headers: context.request.headers,
        message: 'Invalid Email',
      );
    }

    if (context.validatePassword(user.password) != null) {
      return AppRes.error(
        statusCode: HttpStatus.unprocessableEntity,
        headers: context.request.headers,
        message: context.validatePassword(user.password),
      );
    }

    if (userRepo.getUserByEmail(user.email) != null) {
      return AppRes.error(
        headers: context.request.headers,
        message: 'An Account exists with this account',
      );
    }

    userRepo.createUser(user);

    return AppRes.success(
      statusCode: HttpStatus.created,
      headers: context.request.headers,
      data: {
        'token': TokenUtil.createToken(user.id, AppConstants.secretKey),
        'user': user.toMap(),
      },
    );
  } catch (e) {
    return AppRes.fail(
      headers: context.request.headers,
      data: {'error': e.toString()},
    );
  }
}
