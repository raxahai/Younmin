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
}
