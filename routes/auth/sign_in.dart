import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:frog_start/models/app_response.dart';
import 'package:frog_start/models/login_model.dart';
import 'package:frog_start/models/user_model.dart';

Future<Response> onRequest(RequestContext context) async {
  final body = await context.request.json();

  final data = LoginModel.fromMap(jsonDecode(body));

  return Response(
    body: AppResponse.success(
      data: UserModel.random().toMap(),
    ),
  );
}


Handler middleware(Handler handler) {
  return handler.use(provider<String>((context) => 'Welcome to Dart Frog!'));
}