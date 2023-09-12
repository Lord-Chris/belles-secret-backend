// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

class AppRes extends Response {
  final bool status;
  final String? message;
  final Map<String, dynamic>? data;

  AppRes({
    super.statusCode,
    super.headers,
    required this.status,
    this.message,
    this.data,
  });

  Response toJson() {
    return Response.json(
      statusCode: statusCode,
      headers: headers,
      body: {
        'status': status,
        if (data != null) 'data': data,
        if (message != null) 'message': message,
      },
    );
  }

  /// This is called when an API call is rejected due to invalid data or call
  /// conditions
  static Response error({
    int statusCode = HttpStatus.badRequest,
    Map<String, Object>? headers,
    String? message,
  }) {
    return AppRes(
      status: false,
      statusCode: statusCode,
      headers: headers,
      message: message,
    ).toJson();
  }

  /// This is called when an API call is rejected due to an error on the server.
  static Response fail({
    int statusCode = HttpStatus.internalServerError,
    Map<String, Object>? headers,
    Map<String, dynamic>? data,
  }) {
    return AppRes(
      status: false,
      statusCode: statusCode,
      headers: headers,
      data: data,
    ).toJson();
  }

  /// This is called on success cases
  static Response success({
    int statusCode = HttpStatus.ok,
    Map<String, Object>? headers,
    Map<String, dynamic>? data,
  }) {
    return AppRes(
      status: true,
      statusCode: statusCode,
      headers: headers,
      data: data,
    ).toJson();
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
