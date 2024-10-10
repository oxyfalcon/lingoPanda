import 'package:lingopanda/utils/extension.dart';

class Validator {
  static String? validEmail(String? val) {
    if (val != null) {
      if (val.isEmailValid() && val.isNotEmpty) {
        return null;
      } else if (val.isEmpty) {
        return ' Please enter email';
      } else {
        return 'Please enter valid email';
      }
    } else {
      return 'Please enter email';
    }
  }

  static String? passwordValidator(String? val) {
    if (val != null) {
      if (val.isEmpty) {
        return 'Please enter new password';
      } else {
        String error = "";
        if (val.length < 8) {
          error = "Password should be more than 8 characters";
        }
        if (!val.containsUppercaseLetters()) {
          error = "$error\nPlease add at least 1 uppercase letter";
        }
        if (!val.containLowercaseLetters()) {
          error = "$error\nPlease add at least 1 lowercase letter";
        }
        if (!val.containSpecialCharacter()) {
          error =
              "$error\nPlease add at least 1 !@#\$%^&*(),.?:{}|<> character";
        }
        if (!val.containsNumber()) {
          error = "$error\nPlease add at least 1 number";
        }
        if (error.isEmpty) {
          return null;
        } else {
          return error;
        }
      }
    } else {
      return null;
    }
  }

  static String? nameValidator(String? val, [bool optional = false]) {
    if (val != null) {
      if (val.isOnlyText() && val.isNotEmpty) {
        return null;
      } else if (val.isEmpty) {
        return null;
      } else {
        return 'Please enter valid name';
      }
    } else {
      return null;
    }
  }
}
