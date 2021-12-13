import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/features/login/bloc/login_cubit.dart';
import 'package:younmin/features/login/widgets/text_fields.dart';
import 'package:younmin/globals/Strings/login_page_strings.dart';
import 'package:younmin/globals/YounminWidgets/capsule_button.dart';
import 'package:younmin/globals/YounminWidgets/logo_button.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/router/router.gr.dart';

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const LogoButton(),
          ),
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        YounminColors.whiteColor, BlendMode.srcATop),
                    image: AssetImage("assets/images/login/background.png"),
                    fit: BoxFit.cover)),
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SelectableText(
                        LoginStrings.loginToAccount,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 35),
                      ),
                    ),
                    Flexible(child: SizedBox(height: 8.h)),
                    LoginEmailField(controller: _emailController),
                    Flexible(child: SizedBox(height: 3.h)),
                    PasswordField(
                      controller: _passwordController,
                    ),
                    Flexible(child: SizedBox(height: 5.h)),
                    CapsuleButton(
                      minHeight: 50,
                      minWidth: 250,
                      onPressed: () {
                        BlocProvider.of<LoginCubit>(context)
                            .loginWithEmailAndPassword(
                          context,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          formKey: formKey,
                        );
                      },
                      buttonText: LoginStrings.login,
                    ),
                    SizedBox(height: 2.h),
                    TextButton(
                      onPressed: () {
                        context.router.navigate(const SignUpRoute());
                      },
                      child: Text(
                        LoginStrings.createAccount,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: YounminColors.secondaryColor,
                              fontSize: 15,
                            ),
                      ),
                    ),
                    Text(
                      LoginStrings.loginWith,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: YounminColors.secondaryColor,
                            fontSize: 25,
                          ),
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.cente,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<LoginCubit>(context)
                                .loginWithFacebook(context);
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.facebook,
                            color: YounminColors.faceBookColor,
                          ),
                          iconSize: 70,
                          splashRadius: 33,
                          splashColor: YounminColors.primaryColor,
                        ),
                        SizedBox(width: 1.w),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<LoginCubit>(context)
                                .loginWithGoogle(context);
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.googlePlus,
                            color: YounminColors.googleColor,
                          ),
                          iconSize: 70,
                          splashRadius: 31,
                          splashColor: YounminColors.primaryColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
