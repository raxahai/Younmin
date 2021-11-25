import 'package:email_validator/email_validator.dart';

class Validators {
  static String? isValidEmail(String? value) {
    if (value == null) return "email is required to subscribe";
    if (!EmailValidator.validate(value)) {
      return "please enter a valid email";
    }
  }
}
