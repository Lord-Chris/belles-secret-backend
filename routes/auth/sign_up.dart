import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:frog_start/models/app_response.dart';
import 'package:frog_start/models/user_model.dart';

Future<Response> onRequest(RequestContext context) async {
  final body = await context.request.json();

  final user = UserModel.initial(jsonDecode(body));
  return Response(
    body: AppResponse.success(
      data: user.toMap(),
    ),
  );
}
