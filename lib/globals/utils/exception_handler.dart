import 'package:flutter/material.dart';

class ExceptionHandler {
  static final ExceptionHandler _exceptionHandler =
      ExceptionHandler._internal();
  ExceptionHandler._internal();
  factory ExceptionHandler() => _exceptionHandler;

  bool handleFirebaseError(err, context) {
    if (err
        .toString()
        .contains("[firebase_auth/account-exists-with-different-credential]")) {
      _errorSnackBar(context,
          message:
              "this account contains email that already in use, try another account");

      return true;
    } else if (err
        .toString()
        .contains("[firebase_auth/email-already-in-use]")) {
      _errorSnackBar(context,
          message: "this email already in use, try another one");
      return true;
    } else if (err.toString().contains("[firebase_auth/user-not-found]") ||
        err.toString().contains("[firebase_auth/wrong-password]")) {
      _errorSnackBar(context, message: "password or email is wrong");
      return true;
    } else if (err != null) {
      _errorSnackBar(context, message: "something went wrong, try again later");
      return true;
    }
    return false;
  }

  void _errorSnackBar(context, {message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }
}
