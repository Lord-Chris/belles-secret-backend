// ignore_for_file: public_member_api_docs

import 'dart:convert';
import 'dart:math';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class TokenUtil {
  TokenUtil._();

  static String createSecretKey() {
    final random = Random.secure();
    final values = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }

  static String createToken(
    String userId,
    String secretKey, {
    bool isAdmin = false,
  }) {
    final jwt = JWT(
      {
        'iat': DateTime.now().millisecondsSinceEpoch,
        'exp': DateTime.now()
            .add(const Duration(seconds: 60))
            .millisecondsSinceEpoch,
      },
      subject: userId,
    );

    final token = jwt.sign(SecretKey(secretKey));

    print('Signed token: $token\n');
    return token;
  }

  static dynamic checkToken(String token, String secretKey) {
    try {
      // Verify a token
      final jwt = JWT.verify(token, SecretKey(secretKey));

      print('Payload: ${jwt.payload}');
      return jwt.payload;
    } catch (e) {
      //JWTExpiredError
      //JWTError
      print(e);
      rethrow;
    }
  }
}
