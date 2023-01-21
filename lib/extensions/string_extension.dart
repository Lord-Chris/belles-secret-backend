// ignore_for_file: public_member_api_docs

extension StringExtension on String {
  String capitalize() {
    return [split('').first.toUpperCase(), ...split('').skip(1)].join();
  }
}
