// ignore_for_file: public_member_api_docs, only_throw_errors

import 'package:frog_start/models/user_model.dart';

class UserRepository {
  List<UserModel> users = [];

  UserModel createUser(UserModel user) {
    // users.clear();
    users.add(user);
    return user;
  }

  UserModel getUser(String id) {
    return users.firstWhere((user) => user.id == id);
  }

  UserModel? getUserByEmail(String email) {
    try {
      final res = users.where((user) => user.email == email);
      if (res.isEmpty) return null;
      return res.first;
    } on Exception {
      return null;
    }
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
