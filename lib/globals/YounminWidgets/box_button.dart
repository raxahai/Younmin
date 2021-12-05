import 'package:flutter/material.dart';
import 'package:younmin/globals/colors.dart';

class BoxButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final ButtonStyle? buttonStyle;
  const BoxButton({
    Key? key,
    this.onPressed,
    this.buttonText,
    this.buttonTextStyle,
    this.buttonStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Text(
        buttonText!,
        style: buttonTextStyle,
      ),
    );
  }
}
