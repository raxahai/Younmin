import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/YounminWidgets/check_box.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/globals/styles/decoration.dart';
import 'package:younmin/logic/dailyCheckList/daily_check_cubit.dart';
import 'package:younmin/presentation/main/dailyCheck/add_check_list.dart';

List<String> checkList = [
  "Lorem ipsum",
  "have coffee",
  "have breakfast",
  "go to the gym",
  "go to work",
  "watch a spanish movie",
  "learn 50 words of spanish"
];

List<bool> isChecked = List.generate(checkList.length, (index) => false);

class DailyCheckList extends StatelessWidget {
  const DailyCheckList({Key? key, required this.taskDoc}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DailyCheckCubit>(context).getCheck(taskDoc: taskDoc);
    return Container(
      decoration: cardBoxDecoration,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Text(
                      "Goal 1: ",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                IconButton(
                  color: YounminColors.darkPrimaryColor,
                  iconSize: 10.sp,
                  onPressed: () {
                    showModalBottomSheet<dynamic>(
                      backgroundColor: YounminColors.backGroundColor,
                      shape: RoundedRectangleBorder(
                        //the rounded corner is created here
                        borderRadius: BorderRadius.circular(5.sp),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<DailyCheckCubit>(context),
                        child: AddCheck(
                          taskDoc: taskDoc,
                        ),
                      ),
                    );
                  },
                  icon: FaIcon(Icons.add_circle_outline),
                )
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<DailyCheckCubit, DailyCheckState>(
                builder: (context, state) {
              return ImplicitlyAnimatedList(
                items: state.dailyCheckDocs,
                controller: ScrollController(),
                padding: EdgeInsets.fromLTRB(2.sp, 5.sp, 2.sp, 2.sp),
                itemBuilder: (BuildContext _,
                    animation,
                    QueryDocumentSnapshot<Map<String, dynamic>> item,
                    int index) {
                  return ListTile(
                    minLeadingWidth: 10.w,
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 10.w),
                      child: Text(
                        "${index + 1}.${item["check"]}",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        YounminCheckBox(
                          value: item["isChecked"],
                          onChanged: (value) {},
                        ),
                        IconButton(
                            onPressed: () {
                              // BlocProvider.of<DailyCheckCubit>(context)
                            },
                            icon: const FaIcon(Icons.close)),
                      ],
                    ),
                  );
                },
                areItemsTheSame: (QueryDocumentSnapshot<Map<String, dynamic>>
                            oldItem,
                        QueryDocumentSnapshot<Map<String, dynamic>> newItem) =>
                    oldItem["date"] == newItem["date"],

                // itemCount: checkList.length,
                // separatorBuilder: (BuildContext context, int index) =>
                //     const Divider(),
              );
            }),
          )
        ],
      ),
    );
  }
}