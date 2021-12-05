import 'package:flutter/material.dart';

class CapsuleButton extends StatelessWidget {
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final void Function()? onPressed;
  final Color? buttonTextColor;
  final double? minWidth;
  final double? minHeight;
  final ButtonStyle? buttonStyle;
  const CapsuleButton({
    Key? key,
    this.onPressed,
    this.buttonText,
    this.buttonTextStyle,
    this.buttonTextColor,
    this.minWidth,
    this.minHeight,
    this.buttonStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: buttonStyle ??
          Theme.of(context).elevatedButtonTheme.style!.copyWith(
              // backgroundColor: YounminColors.materialStatePrimaryColor,
              minimumSize: MaterialStateProperty.all<Size>(Size(
                minWidth ?? 160,
                minHeight ?? 0,
              )),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              )),
      onPressed: onPressed,
      child: Text(
        buttonText!,
        style: buttonTextStyle ??
            Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontSize: 16, color: buttonTextColor ?? Colors.black),
      ),
    );
  }
}
