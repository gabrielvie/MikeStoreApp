import 'package:flutter/foundation.dart';

class HttpException implements Exception {
  final int code;
  final String error;

  final Map<String, String> _knowErrors = {
    'EMAIL_NOT_FOUND': 'There is no user record corresponding to this email.',
    'INVALID_PASSWORD': 'The password is invalid.',
    'USER_DISABLED': 'Your account has been disabled, contact the support.',
    'EMAIL_EXISTS':
        'The email address is already being used by another account.',
  };

  HttpException({
    @required this.code,
    @required this.error,
  });

  @override
  String toString() {
    if (_knowErrors.containsKey(error)) {
      return _knowErrors[error];
    }

    return error;
  }
}
