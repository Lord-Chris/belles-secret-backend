// ignore_for_file: public_member_api_docs

import 'package:chance_dart/chance_dart.dart';
import 'package:frog_start/utils/token_util.dart';

class AppConstants {
  AppConstants._();

  static const mockImage =
      'https://www.bing.com/th?id=OIP.Sa9ZfKEPzreh38i8xrwQJgHaEo&w=316&h=197&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2';

  static const _categories = ['Serum', 'Gas', 'Lipid'];
  static const _collectionSuffix = ['Care', 'Hair', 'Face Care', 'Skin Care'];
  static const _productSuffix = ['Oil', 'Cream', 'Spray', 'Lotion'];

  static String get randCategory {
    return _categories.elementAt(natural(max: _categories.length));
  }

  static String get cSuffix {
    return _collectionSuffix.elementAt(natural(max: _collectionSuffix.length));
  }

  static String get pSuffix {
    return _productSuffix.elementAt(natural(max: _productSuffix.length));
  }

  static final secretKey = TokenUtil.createSecretKey();
}
