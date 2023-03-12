import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:frog_start/constants.dart';
import 'package:frog_start/models/app_response.dart';
import 'package:frog_start/models/login_model.dart';
import 'package:frog_start/repositories/user_repository.dart';
import 'package:frog_start/utils/crypt_util.dart';
import 'package:frog_start/utils/token_util.dart';

Future<Response> onRequest(RequestContext context) async {
  final body = await context.request.json();

  final data = LoginModel.fromMap(body);
  final user = context.read<UserRepository>().getUserByEmail(data.email);

  if (user == null || user.password != CryptUtil.hashPassword(data.password)) {
    return Response.json(
      statusCode: HttpStatus.notFound,
      body: AppResponse.error(
        'Invalid Login Credentials',
      ).toMap(),
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

Handler middleware(Handler handler) {
  return handler.use(provider<String>((context) => 'Welcome to Dart Frog!'));
}
