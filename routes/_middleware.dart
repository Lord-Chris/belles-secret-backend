import 'package:dart_frog/dart_frog.dart';
import 'package:frog_start/repositories/user_repository.dart';

final _userRepo = UserRepository();

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<UserRepository>((_) => _userRepo));
}
