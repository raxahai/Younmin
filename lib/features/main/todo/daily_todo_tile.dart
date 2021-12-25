import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/features/main/bloc/dailyTodo/daily_todo_cubit.dart';
import 'package:younmin/globals/YounminWidgets/check_box.dart';
import 'package:younmin/globals/YounminWidgets/choose_feeling.dart';
import 'package:younmin/globals/colors.dart';

class DailyTodoTile extends StatelessWidget {
  const DailyTodoTile(
      {Key? key,
      this.index,
      required this.item,
      required this.taskDoc,
      this.selectedDate})
      : super(key: key);

  final int? index;
  final QueryDocumentSnapshot<Map<String, dynamic>> item;
  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;
  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showModalBottomSheet<dynamic>(
          backgroundColor: YounminColors.secondaryColor,
          shape: RoundedRectangleBorder(
            //the rounded corner is created here
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.sp),
              topRight: Radius.circular(5.sp),
            ),
          ),
          isScrollControlled: true,
          constraints: BoxConstraints(maxWidth: 60.w),
          context: context,
          builder: (_) => ChooseFeeling(
            onChoosed: (feelingNumber) {
              BlocProvider.of<DailyTodoCubit>(context).changeFeeling(context,
                  feeling: feelingNumber,
                  todoDoc: item,
                  taskDoc: taskDoc,
                  date: selectedDate);
            },
          ),
        );
      },
      contentPadding: EdgeInsets.zero,
      title: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: 8.sp,
          height: 8.sp,
          child: Image.asset("assets/images/emoji/${item["feeling"]}.png"),
        ),
      ),
      // minLeadingWidth: 10.w,
      leading: Tooltip(
        message: "${(index ?? -1) + 1}.${item["todo"]}",
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 24.w),
          child: Text(
            "${(index ?? -1) + 1}. ${item["todo"]}",
            overflow: TextOverflow.ellipsis,
            style:
                Theme.of(context).textTheme.headline3!.copyWith(fontSize: 5.sp),
          ),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          YounminCheckBox(
            value: item["isChecked"],
            onChanged: (value) {
              BlocProvider.of<DailyTodoCubit>(context)
                  .changeIsChecked(value: value, todoDoc: item);
            },
          ),
          IconButton(
              padding: EdgeInsets.zero,
              iconSize: 35,
              onPressed: () {
                BlocProvider.of<DailyTodoCubit>(context).deleteDailyTodo(
                    todoDoc: item, taskDoc: taskDoc, date: selectedDate);
              },
              icon: const FaIcon(Icons.close)),
        ],
      ),
    );
  }
}
