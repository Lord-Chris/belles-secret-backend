// ignore_for_file: public_member_api_docs

import 'package:dart_frog/dart_frog.dart';

class AppRes extends Response {
  final String status;
  final String? message;
  final Map<String, dynamic>? data;

  AppRes({
    required this.status,
    super.statusCode,
    this.message,
    this.data,
  });

  factory AppRes.error(String? message) {
    return AppRes(status: 'error', message: message);
  }

  factory AppRes.fail({Map<String, dynamic>? data}) {
    return AppRes(status: 'fail', data: data);
  }

  factory AppRes.success({Map<String, dynamic>? data}) {
    return AppRes(status: 'success', data: data);
  }

  Map<String, dynamic> toMap() {
    switch (status) {
      case 'success':
        return _toSuccessMap();
      case 'fail':
        return _toFailureMap();
      default:
        return _toErrorMap();
    }
  }

  Map<String, dynamic> _toSuccessMap() {
    return {
      'status': status,
      'data': data,
    };
  }

  Map<String, dynamic> _toFailureMap() {
    return {
      'status': status,
      'data': data,
    };
  }

  Map<String, dynamic> _toErrorMap() {
    return {
      'status': status,
      if (message != null) 'message': message,
    };
  }
}

class AppResponse {
  AppResponse({
    required this.status,
    this.message,
    this.data,
  });

  factory AppResponse.error(String? message) {
    return AppResponse(status: 'error', message: message);
  }

  factory AppResponse.fail({Map<String, dynamic>? data}) {
    return AppResponse(status: 'fail', data: data);
  }

  factory AppResponse.success({Map<String, dynamic>? data}) {
    return AppResponse(status: 'success', data: data);
  }

  final String status;
  final String? message;
  final Map<String, dynamic>? data;

  Map<String, dynamic> toMap() {
    switch (status) {
      case 'success':
        return _toSuccessMap();
      case 'fail':
        return _toFailureMap();
      default:
        return _toErrorMap();
    }
  }

  Map<String, dynamic> _toSuccessMap() {
    return {
      'status': status,
      'data': data,
    };
  }

  Map<String, dynamic> _toFailureMap() {
    return {
      'status': status,
      'data': data,
    };
  }

  Map<String, dynamic> _toErrorMap() {
    return {
      'status': status,
      if (message != null) 'message': message,
    };
  }
}
