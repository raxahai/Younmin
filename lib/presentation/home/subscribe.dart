import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:younmin/globals/Strings/global_strings.dart';
import 'package:younmin/globals/Strings/home_page_strings.dart';
import 'package:younmin/globals/YounminWidgets/custom_text_field.dart';
import 'package:younmin/globals/validators.dart';
import 'package:younmin/logic/subscribe/subscribe_cubit.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
final TextEditingController emailController = TextEditingController();

class Subscribe extends StatelessWidget {
  const Subscribe({
    Key? key,
    this.animate = false,
  }) : super(key: key);

  final bool animate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SubscribeCubit(),
      child: Builder(builder: (context) {
        return FadeInDown(
          animate: true,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SelectableText(
                  HomePageStrings5.mainText,
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
                SelectableText(
                  HomePageStrings5.subText,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 30,
                ),
                CustomTextField(
                  width: 400,
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: GlobalStrings.enterEmail,
                    isDense: true,
                  ),
                  validator: Validators.isValidEmail,
                ),
                Container(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<SubscribeCubit>(context).subscribeWithEmail(
                        context,
                        formKey: formKey,
                        emailController: emailController);
                  },
                  child: Text(
                    GlobalStrings.sendEmail,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
