import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/features/yearlyTodo/bloc/yearly_todo_cubit.dart';
import 'package:younmin/globals/YounminWidgets/capsule_button.dart';
import 'package:younmin/globals/YounminWidgets/custom_text_field.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/globals/utils/validators.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.sp),
      ),
      elevation: 0,
      backgroundColor: YounminColors.lightBlack,
      child: SizedBox(
        width: 55.w,
        height: 65.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 5.sp),
          child: ProgressHUD(
            child: Builder(
              builder: (context) => Form(
                key: formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Edit your profile",
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 10.sp),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "First name",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: YounminColors.secondaryColor,
                                  ),
                            ),
                          ),
                          CustomTextField(
                            controller: firstNameController,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: YounminColors.secondaryColor,
                                    ),
                            validator: Validators.isRequired,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Last name",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: YounminColors.secondaryColor,
                                  ),
                            ),
                          ),
                          CustomTextField(
                            controller: lastNameController,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: YounminColors.secondaryColor,
                                    ),
                            validator: Validators.isRequired,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Age",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: YounminColors.secondaryColor,
                                  ),
                            ),
                          ),
                          CustomTextField(
                            controller: ageController,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: YounminColors.secondaryColor,
                                    ),
                            validator: Validators.isValidAge,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CapsuleButton(
                      onPressed: () {
                        BlocProvider.of<YearlyTodoCubit>(context).editProfile(
                          context,
                          firstNameController: firstNameController,
                          lastNameController: lastNameController,
                          ageController: ageController,
                          emailController: emailController,
                          formKey: formKey,
                        );
                      },
                      minWidth: double.infinity,
                      minHeight: 10.h,
                      buttonText: 'Edit',
                      buttonTextStyle:
                          Theme.of(context).textTheme.headline4!.copyWith(
                                fontSize: 7.sp,
                              ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
