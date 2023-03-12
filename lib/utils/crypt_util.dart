// ignore_for_file: public_member_api_docs

import 'package:crypt/crypt.dart';

class CryptUtil {
  static String hashPassword(String password) {
    final c2 = Crypt.sha256(password, rounds: 10000, salt: '12345');
    return c2.toString();
  }
}
