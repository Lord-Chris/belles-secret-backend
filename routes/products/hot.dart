import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final request = context.request;
  print(context);
  print(request);

  return Response(body: 'This is the Hot Products section');
}
