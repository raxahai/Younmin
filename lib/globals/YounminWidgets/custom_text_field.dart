import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double? height;
  final double? width;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final TextStyle? style;
  final String? Function(String?)? validator;
  final bool obscureText;
  const CustomTextField({
    Key? key,
    this.controller,
    this.decoration,
    this.style,
    this.validator,
    this.height,
    this.width,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        autocorrect: false,
        controller: controller,
        decoration: decoration,
        style: style,
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
