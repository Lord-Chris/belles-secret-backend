// ignore_for_file: public_member_api_docs

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

  Map<String, dynamic> toSuccessMap() {
    return {
      'status': status,
      'data': data,
    };
  }

  Map<String, dynamic> toFailureMap() {
    return {
      'status': status,
      'data': data,
    };
  }

  Map<String, dynamic> toErrorMap() {
    return {
      'status': status,
      if (message != null) 'message': message,
    };
  }
}
