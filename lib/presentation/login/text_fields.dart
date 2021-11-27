import 'package:flutter/material.dart';
import 'package:younmin/globals/Strings/login_page_strings.dart';
import 'package:younmin/globals/YounminWidgets/custom_text_field.dart';
import 'package:younmin/globals/validators.dart';

class LoginEmailField extends StatelessWidget {
  const LoginEmailField({
    Key? key,
    this.controller,
  }) : super(key: key);

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: CustomTextField(
        width: 500,
        controller: controller,
        decoration: InputDecoration(
          hintText: LoginStrings.email,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 30),
        validator: Validators.isValidEmail,
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    this.controller,
  }) : super(key: key);

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: CustomTextField(
        width: 500,
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          hintText: LoginStrings.password,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 30),
        validator: Validators.isRequired,
      ),
    );
  }
}
