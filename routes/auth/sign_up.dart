import 'dart:developer';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:frog_start/constants.dart';
import 'package:frog_start/models/app_response.dart';
import 'package:frog_start/models/user_model.dart';
import 'package:frog_start/repositories/user_repository.dart';
import 'package:frog_start/utils/token_util.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
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
  } on Response catch (e) {
    print(e.toString());
    return e;
  } catch (e) {
    print(e.toString());
    return Response.json(
      statusCode: HttpStatus.internalServerError,
      body: AppResponse.fail(
        data: {},
      ).toMap(),
    );
  }
}
