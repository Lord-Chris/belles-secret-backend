// ignore_for_file: public_member_api_docs

import 'package:chance_dart/chance_dart.dart';

class AppConstants {
  AppConstants._();

  static const mockImage =
      'https://www.bing.com/th?id=OIP.Sa9ZfKEPzreh38i8xrwQJgHaEo&w=316&h=197&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2';

  static const _collectionSuffix = ['Care', 'Hair', 'Face Care', 'Skin Care'];
  static String get cSuffix {
    return _collectionSuffix.elementAt(natural(max: _collectionSuffix.length));
  }
}
