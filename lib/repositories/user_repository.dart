// ignore_for_file: public_member_api_docs, only_throw_errors

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:frog_start/models/app_response.dart';
import 'package:frog_start/models/user_model.dart';

class UserRepository {
  List<UserModel> users = [];

  UserModel createUser(UserModel user) {
    // users.clear();
    if (getUserByEmail(user.email) != null) {
      throw Response.json(
        statusCode: HttpStatus.notFound,
        body: AppResponse.error('An account exists with this account already')
            .toMap(),
      );
    }
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
