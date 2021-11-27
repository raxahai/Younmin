import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final double? height;
  final double? width;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final TextStyle? style;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  const CustomTextField({
    Key? key,
    this.controller,
    this.decoration,
    this.style,
    this.validator,
    this.height,
    this.width,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
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
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
      ),
    );
  }
}
