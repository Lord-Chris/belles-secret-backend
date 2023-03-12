// ignore_for_file: public_member_api_docs

import 'package:dart_frog/dart_frog.dart';
import 'package:frog_start/models/user_model.dart';

class UserRepository {
  List<UserModel> users = [];

  UserModel createUser(UserModel user) {
    users.add(user);
    return user;
  }

  UserModel getUser(String id) {
    return users.firstWhere((user) => user.id == id);
  }

  UserModel updateUser(String id, UserModel newData) {
    final index = users.indexWhere((user) => user.id == id);
    users[index] = users[index].copyWith(
      country: newData.country,
      email: newData.email,
      gender: newData.gender,
      phone: newData.phone,
    );

    return users[index];
  }

  void deleteUser(String id) {
    return users.removeWhere((user) => user.id == id);
  }
}

final _userRepo = UserRepository();

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<UserRepository>((_) => _userRepo));
}
