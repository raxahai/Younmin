import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:younmin/features/sign_up/bloc/sign_up_cubit.dart';
import 'package:younmin/globals/Strings/sign_up_page_strings.dart';
import 'package:younmin/globals/YounminWidgets/custom_text_field.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/globals/utils/validators.dart';

class FirstNameAndGender extends StatelessWidget {
  const FirstNameAndGender({
    Key? key,
    this.controller,
    required this.onGenderChange,
  }) : super(key: key);

  final TextEditingController? controller;
  final void Function(bool) onGenderChange;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      width: 500,
      controller: controller,
      decoration: InputDecoration(
        hintText: SignUpStrings.firstName,
        isDense: true,
        suffixIconConstraints:
            const BoxConstraints(maxWidth: 80, maxHeight: 35),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(4),
          child: RollingSwitch.icon(
            width: 80,
            onChanged: onGenderChange,
            rollingInfoRight: const RollingIconInfo(
              icon: Icons.male,
            ),
            rollingInfoLeft: const RollingIconInfo(
              icon: Icons.female,
              backgroundColor: Colors.pink,
            ),
          ),
        ),
      ),
      style: Theme.of(context).textTheme.headline3!.copyWith(
            fontSize: 20,
            color: YounminColors.secondaryColor,
          ),
      validator: Validators.isValidFirstName,
    );
  }
}

class LastNameAndAge extends StatelessWidget {
  const LastNameAndAge({
    Key? key,
    this.lastNameController,
    this.ageController,
  }) : super(key: key);

  final TextEditingController? lastNameController;
  final TextEditingController? ageController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: CustomTextField(
            width: 400,
            controller: lastNameController,
            decoration: InputDecoration(
              isDense: true,
              hintText: SignUpStrings.lastName,
            ),
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: 20,
                  color: YounminColors.secondaryColor,
                ),
            validator: Validators.isValidLastName,
          ),
        ),
        SizedBox(width: 30),
        CustomTextField(
          width: 70,
          controller: ageController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter
                .digitsOnly, // Only numbers can be entered
            LengthLimitingTextInputFormatter(
                3), // only 3 numbers can be entered
          ],
          decoration: InputDecoration(
            hintText: SignUpStrings.age,
            isDense: true,
          ),
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontSize: 20,
                color: YounminColors.secondaryColor,
              ),
          validator: Validators.isValidAge,
        ),
      ],
    );
  }
}

class SignUpEmailField extends StatelessWidget {
  const SignUpEmailField({
    Key? key,
    this.controller,
  }) : super(key: key);

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      width: 500,
      controller: controller,
      decoration: InputDecoration(
          hintText: SignUpStrings.email,
          isDense: true,
          suffixIcon: BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (preState, state) => state.imageFile != null,
            builder: (BuildContext context, state) {
              if (state.imageFile != null) {
                return IconButton(
                  iconSize: 30,
                  tooltip: "profile image",
                  icon: Image.memory(state.imageFile!),
                  onPressed: () {
                    BlocProvider.of<SignUpCubit>(context).uploadImage();
                  },
                );
              }
              return IconButton(
                iconSize: 30,
                tooltip: "profile image",
                icon: const FaIcon(
                  FontAwesomeIcons.fileImage,
                  color: YounminColors.secondaryColor,
                ),
                onPressed: () {
                  BlocProvider.of<SignUpCubit>(context).uploadImage();
                },
              );
            },
          )),
      style: Theme.of(context)
          .textTheme
          .headline3!
          .copyWith(fontSize: 20, color: YounminColors.secondaryColor),
      validator: Validators.isValidEmail,
    );
  }
}

String? password;

class PasswordFields extends StatelessWidget {
  const PasswordFields({
    Key? key,
    this.passwordController,
    this.confirmController,
  }) : super(key: key);
  final TextEditingController? passwordController;
  final TextEditingController? confirmController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: CustomTextField(
            width: 245,
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: SignUpStrings.password,
              isDense: true,
            ),
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: 20,
                  color: YounminColors.secondaryColor,
                ),
            validator: Validators.isValidPassword,
            onChanged: (value) {
              password = value;
            },
          ),
        ),
        Padding(padding: const EdgeInsets.all(5.0)),
        Flexible(
          child: SizedBox(
            width: 245,
            child: CustomTextField(
              controller: confirmController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: SignUpStrings.confirmPassword,
                isDense: true,
              ),
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: 20,
                    color: YounminColors.secondaryColor,
                  ),
              validator: (value) => Validators.isValidConfirmPassword(
                  value, passwordController!.text),
            ),
          ),
        ),
      ],
    );
  }
}
