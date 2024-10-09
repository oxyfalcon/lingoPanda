import 'package:flutter/services.dart';

extension UriSetter on Uri {
  Uri copyWith(
      {String? scheme,
      String? userInfo,
      String? host,
      int? port,
      String? path,
      Iterable<String>? pathSegments,
      String? query,
      Map<String, dynamic>? queryParameters,
      String? fragment}) {
    return Uri(
      scheme: scheme ?? this.scheme,
      userInfo: userInfo ?? this.userInfo,
      host: host ?? this.host,
      port: port ?? this.port,
      path: path ?? this.path,
      query: query ?? this.query,
      queryParameters: queryParameters ?? this.queryParameters,
      fragment: fragment ?? this.fragment,
    );
  }
}

extension FormValidation on String {
  bool isEmailValid() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  bool isOnlyText() {
    return RegExp(
      r'^[a-zA-Z\s-]+$',
      caseSensitive: false,
      multiLine: false,
    ).hasMatch(this);
  }

  bool containSpecialCharacter() {
    return RegExp(
      r'[!@#\$%^&*(),.?":{}|<>]',
      caseSensitive: false,
      multiLine: false,
    ).hasMatch(this);
  }

  bool containsNumber() {
    return RegExp(
      r'[0-9]',
      caseSensitive: false,
      multiLine: false,
    ).hasMatch(this);
  }

  bool containsUppercaseLetters() {
    return RegExp(
      r'[A-Z]',
      caseSensitive: true,
      multiLine: false,
    ).hasMatch(this);
  }

  bool containLowercaseLetters() {
    return RegExp(r'[a-z]', caseSensitive: true, multiLine: false)
        .hasMatch(this);
  }
}

class UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    newValue = newValue.copyWith(text: newValue.text.toLowerCase());
    return newValue;
  }
}
