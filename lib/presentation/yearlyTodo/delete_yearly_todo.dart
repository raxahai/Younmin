import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:younmin/globals/Strings/yearlyTodo_page_strings.dart';
import 'package:younmin/globals/YounminWidgets/box_button.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/logic/yearlyTodo/yearly_todo_cubit.dart';

class DeleteYearlyTodo extends StatelessWidget {
  const DeleteYearlyTodo({Key? key, required this.taskDoc}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        YearlyTodoStrings.deleteTask,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline3!
            .copyWith(color: YounminColors.textHeadline1Color),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        BoxButton(
          buttonText: YearlyTodoStrings.close,
          buttonTextStyle: Theme.of(context).textTheme.bodyText1,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        BoxButton(
          buttonText: YearlyTodoStrings.delete,
          buttonTextStyle: Theme.of(context).textTheme.bodyText1,
          buttonStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                YounminColors.redColor,
              ),
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.all<Color>(
                YounminColors.transparentColor,
              )),
          onPressed: () {
            BlocProvider.of<YearlyTodoCubit>(context)
                .deleteYearlyTodo(context, doc: taskDoc);
          },
        ),
      ],
    );
  }
}
