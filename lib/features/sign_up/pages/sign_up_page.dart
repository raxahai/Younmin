import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/features/sign_up/bloc/sign_up_cubit.dart';
import 'package:younmin/features/sign_up/widgets/text_fields.dart';
import 'package:younmin/globals/Strings/sign_up_page_strings.dart';
import 'package:younmin/globals/YounminWidgets/capsule_button.dart';
import 'package:younmin/globals/YounminWidgets/logo_button.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/router/router.gr.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

bool isMale = false;

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) => SignUpCubit(),
      child: ProgressHUD(
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const LogoButton(
                textColor: YounminColors.secondaryColor,
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        YounminColors.secondaryColor,
                        BlendMode.srcATop,
                      ),
                      image: AssetImage("assets/images/login/background.png"),
                      fit: BoxFit.cover)),
              child: Center(
                child: Form(
                  key: formKey,
                  child: BlocBuilder<SignUpCubit, SignUpState>(
                      buildWhen: (preState, state) =>
                          preState.visible != state.visible,
                      builder: (BuildContext context, state) {
                        return IgnorePointer(
                          ignoring: state.visible,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              BlocBuilder<SignUpCubit, SignUpState>(
                                  builder: (BuildContext context, state) {
                                return Visibility(
                                  visible: state.visible,
                                  child: CircularPercentIndicator(
                                    radius: 20.sp,
                                    lineWidth: 2.sp,
                                    percent: state.progress,
                                    center: Text((state.progress * 100)
                                        .toStringAsFixed(2)),
                                    progressColor: Colors.green,
                                  ),
                                );
                              }),
                              SelectableText(
                                SignUpStrings.signUpToAccount,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(fontSize: 35),
                                textAlign: TextAlign.center,
                              ),
                              Container(
                                height: 50,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: FirstNameAndGender(
                                  controller: firstNameController,
                                  onGenderChange: (state) {
                                    isMale = state;
                                  },
                                ),
                              ),
                              Flexible(child: SizedBox(height: 20)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: LastNameAndAge(
                                  lastNameController: lastNameController,
                                  ageController: ageController,
                                ),
                              ),
                              Flexible(child: SizedBox(height: 20)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: SignUpEmailField(
                                  controller: emailController,
                                ),
                              ),
                              Flexible(child: SizedBox(height: 20)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: PasswordFields(
                                  passwordController: passwordController,
                                  confirmController: confirmPasswordController,
                                ),
                              ),
                              Container(
                                height: 5.h,
                              ),
                              CapsuleButton(
                                minHeight: 50,
                                minWidth: 250,
                                onPressed: () {
                                  BlocProvider.of<SignUpCubit>(context).signUp(
                                    context,
                                    firstNameController: firstNameController,
                                    lastNameController: lastNameController,
                                    ageController: ageController,
                                    emailController: emailController,
                                    passwordController: passwordController,
                                    confirmPasswordController:
                                        confirmPasswordController,
                                    isMale: isMale,
                                    formKey: formKey,
                                  );
                                },
                                buttonText: SignUpStrings.signUp,
                                // style: Theme.of(context)
                                //     .textTheme
                                //     .headline3!
                                //     .copyWith(fontSize: 25),
                                // ),
                              ),
                              Container(
                                height: 20,
                              ),
                              Text(
                                SignUpStrings.alreadyHasAccount,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                      color: YounminColors.secondaryColor,
                                      fontSize: 25,
                                    ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.router.navigate(const LoginRoute());
                                },
                                child: Text(
                                  SignUpStrings.login,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        color: YounminColors.secondaryColor,
                                        fontSize: 30,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
