import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:frog_start/constants.dart';
import 'package:frog_start/models/app_response.dart';
import 'package:frog_start/models/user_model.dart';
import 'package:frog_start/utils/token_util.dart';

Future<Response> onRequest(RequestContext context) async {
  final body = await context.request.json();

  final user = UserModel.initial(jsonDecode(body));
  return Response(
    body: AppResponse.success(
      data: {
        'token': TokenUtil.createToken(user.id, AppConstants.secretKey),
        'user': user.toMap(),
      },
    ),
  );
}
