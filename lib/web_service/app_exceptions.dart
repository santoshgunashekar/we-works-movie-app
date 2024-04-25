import 'package:http/http.dart';

class AppException implements Exception {
  AppException(Response response, [String? message])
      : this.allArgs(response.statusCode, message, response.body);

  AppException.allArgs(this.statusCode, this.errorMessage, this.errorBody);

  AppException throwExceptionForResponse([String? message]) {
    final int statusCode = response.statusCode;
    if (statusCode == 401) {
      return UnAuthorizedException(response, "Authorization failed");
    } else if (statusCode >= 500) {
      return InternalServerException(response, "Internal server error");
    }
    return AppException(response, "Something went wrong");
  }

  late int? statusCode;
  late dynamic errorBody;
  String? errorMessage;
  late Response response;
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException(super.response, super.message);
}

class InternalServerException extends AppException {
  InternalServerException(super.response, super.message);
}
