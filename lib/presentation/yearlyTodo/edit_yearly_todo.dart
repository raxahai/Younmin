import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/Strings/yearlyTodo_page_strings.dart';
import 'package:younmin/globals/YounminWidgets/capsule_button.dart';
import 'package:younmin/globals/YounminWidgets/choose_feeling.dart';
import 'package:younmin/globals/YounminWidgets/custom_text_field.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/logic/yearlyTodo/yearly_todo_cubit.dart';

class EditYearlyTodo extends StatefulWidget {
  const EditYearlyTodo({Key? key, required this.taskDoc}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;

  @override
  _EditYearlyTodoState createState() => _EditYearlyTodoState();
}

int feeling = 1;
TextEditingController goalController = TextEditingController();

class _EditYearlyTodoState extends State<EditYearlyTodo> {
  @override
  void initState() {
    goalController.text = widget.taskDoc['goal'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.sp),
      ),
      elevation: 0,
      backgroundColor: YounminColors.lightBlack,
      child: Container(
        width: 55.w,
        height: 60.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 5.sp),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                YearlyTodoStrings.editYourGoal,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 10.sp),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  YearlyTodoStrings.whatToDoYear,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: YounminColors.secondaryColor),
                ),
              ),
              SizedBox(height: 1.h),
              SizedBox(
                width: double.infinity,
                child: CustomTextField(
                  controller: goalController,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              SizedBox(height: 3.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  YearlyTodoStrings.feelingAchieveGoal,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: YounminColors.secondaryColor),
                ),
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
                  height: 12.h,
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
                    BlocProvider.of<YearlyTodoCubit>(context).updateYearlyTodo(
                        context,
                        goalController: goalController,
                        feeling: feeling,
                        doc: widget.taskDoc);
                  },
                  minWidth: double.infinity,
                  minHeight: 10.h,
                  buttonText: YearlyTodoStrings.editGoal,
                  buttonTextStyle:
                      Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 7.sp,
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
