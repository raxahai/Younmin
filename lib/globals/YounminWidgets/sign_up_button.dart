import 'package:flutter/material.dart';
import 'package:younmin/globals/Strings/global_strings.dart';
import 'package:younmin/globals/YounminWidgets/capsule_button.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CapsuleButton(
      onPressed: onPressed,
      buttonText: GlobalStrings.signUp,
    );
  }
}
