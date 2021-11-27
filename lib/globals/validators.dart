import 'package:email_validator/email_validator.dart';

class Validators {
  static String? isValidEmail(String? value) {
    if (value!.isEmpty) return "email is required";
    if (!EmailValidator.validate(value)) {
      return "please enter a valid email";
    }
  }

  static String? isRequired(String? value) {
    if (value!.isEmpty) return "Required";
  }

  static String? isValidFirstName(String? value) {
    if (value!.length < 3) {
      return "First name must be at least 3 characters";
    }
    return null;
  }

  static String? isValidLastName(String? value) {
    if (value!.length < 3) {
      return "Last name must be at least 3 characters";
    }
    return null;
  }

  static String? isValidAge(String? value) {
    if (value!.isEmpty) {
      return "required";
    }
    if (double.parse(value) >= 13 && double.parse(value) <= 150) {
      return null;
    }
    return "between 8 & 150";
  }

  static String? isValidPassword(String? value) {
    if (value!.length < 6) {
      return "Must be at least 6 characters";
    }
    return null;
  }

  static String? isValidConfirmPassword(
      String? value, String? passwordToCompare) {
    String? message = isValidPassword(value);
    if (passwordToCompare!.isEmpty) return message;
    if (message == null && value != passwordToCompare) {
      message = 'Same password required';
    }
    return message;
  }
}
