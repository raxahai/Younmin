import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/features/yearlyTodo/bloc/yearly_todo_cubit.dart';
import 'package:younmin/globals/YounminWidgets/capsule_button.dart';
import 'package:younmin/globals/YounminWidgets/choose_feeling.dart';
import 'package:younmin/globals/YounminWidgets/custom_text_field.dart';
import 'package:younmin/globals/YounminWidgets/on_hover_button.dart';
import 'package:younmin/globals/colors.dart';

class AddYearlyTodo extends StatefulWidget {
  const AddYearlyTodo({Key? key}) : super(key: key);

  @override
  _AddYearlyTodoState createState() => _AddYearlyTodoState();
}

int feeling = 1;
TextEditingController goalController = TextEditingController();

class _AddYearlyTodoState extends State<AddYearlyTodo> {
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
        height: 63.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 5.sp),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Add new goal for the year",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 10.sp),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Add new goal for the year",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: YounminColors.textHeadline1Color)),
              ),
              SizedBox(height: 1.h),
              SizedBox(
                width: double.infinity,
                child: CustomTextField(
                  controller: goalController,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: YounminColors.secondaryColor,
                      ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("That feeling when you achieve your goal",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: YounminColors.textHeadline1Color)),
              ),
              SizedBox(height: 1.h),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.sp), // if you need this
                  side: const BorderSide(
                    color: YounminColors.textFieldColor,
                    width: 2,
                  ),
                ),
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: 15.h,
                  child: ChooseFeeling(onChoosed: (feelingNum) {
                    feeling = feelingNum;
                  }),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: CapsuleButton(
                  onPressed: () {
                    BlocProvider.of<YearlyTodoCubit>(context)
                        .createNewYearlyTodo(context,
                            goalController: goalController, feeling: feeling);
                  },
                  minWidth: double.infinity,
                  minHeight: 10.h,
                  buttonText: 'Add goal',
                  buttonTextStyle:
                      Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 7.sp,
                          ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
