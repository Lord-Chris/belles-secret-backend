import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(body: 'Welcome to Dart Frog!');
}

Handler middleware(Handler handler) {
  return handler.use(provider<String>((context) => 'Welcome to Dart Frog!'));
}


/// TODO: 
/// 1. New Arrivals product ✅
/// 2. Search product ✅
/// 3. Get Wishlist ✅
/// 4. Fix analysis-options
/// 5. Add error catchers - for content type 




/// Chance-dart suggestions.
/// 1. Email generator
/// 2. JWT generator