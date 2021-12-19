import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:younmin/features/login/bloc/login_cubit.dart';
import 'package:younmin/features/main/bloc/dailyCheckList/daily_check_cubit.dart';
import 'package:younmin/features/main/bloc/dailyTodo/daily_todo_cubit.dart';
import 'package:younmin/features/main/bloc/history/history_cubit.dart';
import 'package:younmin/features/main/pages/recent_progress.dart';
import 'package:younmin/features/main/widgets/overall_yearly_progress.dart';
import 'package:younmin/features/sentences/bloc/sentences_cubit.dart';
import 'package:younmin/features/sentences/pages/sentences_page.dart';
import 'package:younmin/globals/Strings/main_page_strings.dart';
import 'package:younmin/globals/YounminWidgets/app_bar.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/globals/styles/decoration.dart';
import 'package:younmin/globals/utils/helping_functions.dart';
import 'package:younmin/router/router.gr.dart';

import '../dailyCheck/daily_check_list.dart';
import '../todo/daily_todo.dart';

late QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;

double yearlyProgress = 0;
double monthlyProgress = 0;
double dailyProgress = 0;

DateTime? selectedDate;

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
    this.taskOrderNum = 1,
    @PathParam("id") this.docid = "default",
  }) : super(key: key);

  final int taskOrderNum;
  final String docid;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<bool> getTaskDoc() async {
    await Future.delayed(const Duration(seconds: 1));
    final userDate = await getUserData();
    final snapshot = await userDate.docs.first.reference
        .collection("yearlyTodo")
        .doc(widget.docid)
        .get();
    // querying it again with a where command so we get a QueryDocumentSnapshot not a documentSnapshot
    final taskDocs = await userDate.docs.first.reference
        .collection("yearlyTodo")
        .where("createdAt", isEqualTo: snapshot["createdAt"])
        .get();

    taskDoc = taskDocs.docs.first;
    final year =
        await taskDoc.reference.collection("year").doc(thisYear()).get();

    final month = await taskDoc.reference
        .collection("year")
        .doc(thisYear())
        .collection("month")
        .doc(thisMonth())
        .get();

    final day = await taskDoc.reference
        .collection("year")
        .doc(thisYear())
        .collection("month")
        .doc(thisMonth())
        .collection("days")
        .doc(today())
        .get();
    final yearData = year.data();
    final monthData = month.data();
    final dayData = day.data();

    yearlyProgress = yearData == null ? 0 : yearData["yearlyProgress"];
    monthlyProgress = monthData == null ? 0 : monthData["monthlyProgress"];
    dailyProgress = dayData == null ? 0 : dayData["dailyProgress"];

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => DailyTodoCubit()),
        BlocProvider(create: (BuildContext context) => DailyCheckCubit()),
        BlocProvider(create: (BuildContext context) => SentencesCubit()),
        BlocProvider(create: (BuildContext context) => HistoryCubit()),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBarWithBackActionButton(
            actions: [
              IconButton(
                tooltip: MainPageStrings.questions,
                iconSize: 10.sp,
                // splashRadius: 6.sp,
                onPressed: () {
                  context.router.navigate(const QuestionsRoute());
                },
                icon: const FaIcon(
                  FontAwesomeIcons.questionCircle,
                  color: YounminColors.secondaryColor,
                ),
              ),
              IconButton(
                iconSize: 10.sp,
                onPressed: () {
                  showModalBottomSheet<dynamic>(
                    backgroundColor: YounminColors.backGroundColor,
                    shape: RoundedRectangleBorder(
                      //the rounded corner is created here
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.sp),
                        topRight: Radius.circular(5.sp),
                      ),
                    ),
                    isScrollControlled: true,
                    context: context,
                    builder: (conext) => BlocProvider.value(
                        value: BlocProvider.of<SentencesCubit>(context),
                        child: const Sentences()),
                  );
                },
                splashRadius: 6.sp,
                icon: const FaIcon(
                  Icons.apps_rounded,
                  color: YounminColors.secondaryColor,
                ),
                tooltip: MainPageStrings.sentences,
              ),
              IconButton(
                iconSize: 10.sp,
                onPressed: () {
                  BlocProvider.of<LoginCubit>(context).logout(context);
                },
                icon: const FaIcon(
                  Icons.logout_rounded,
                  color: YounminColors.secondaryColor,
                ),
                tooltip: MainPageStrings.logout,
              ),
            ],
          ),
          body: FutureBuilder(
              future: getTaskDoc(),
              builder: (context, asyncSnapshot) {
                if (!asyncSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            color: YounminColors.darkPrimaryColor,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(3.w, 10.h, 3.w, 4.h),
                              child: Container(
                                decoration: cardBoxDecoration,
                                child: Tooltip(
                                  message: 'chose the date of the task',
                                  child: SfDateRangePicker(
                                    selectionColor: YounminColors.primaryColor,
                                    rangeSelectionColor:
                                        YounminColors.primaryColor,
                                    todayHighlightColor:
                                        YounminColors.primaryColor,
                                    onSelectionChanged:
                                        (DateRangePickerSelectionChangedArgs
                                            args) {
                                      BlocProvider.of<DailyTodoCubit>(context)
                                          .getDailyTodo(
                                              taskDoc: taskDoc,
                                              date: args.value);
                                      BlocProvider.of<DailyCheckCubit>(context)
                                          .getCheck(
                                              taskDoc: taskDoc,
                                              date: args.value);
                                      setState(() {
                                        selectedDate = args.value;
                                      });
                                    },
                                    selectionMode:
                                        DateRangePickerSelectionMode.single,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: YounminColors.primaryColor,
                              child: OverAllYearlyProgress(
                                monthlyPercentage: monthlyProgress,
                                yearlyPercentage: yearlyProgress,
                              ),
                            ),
                          ),
                        ],
                      ),
                      flex: 2,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3.h, horizontal: 2.5.w),
                              child: Text(
                                "${MainPageStrings.goal} ${widget.taskOrderNum}: ${taskDoc['goal']}",
                                style: Theme.of(context).textTheme.headline2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: Row(
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: DailyTodo(
                                      taskDoc: taskDoc,
                                      selectedDate: selectedDate,
                                    ),
                                    flex: 7,
                                  ),
                                  SizedBox(width: 2.w),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: DailyCheckList(
                                        taskDoc: taskDoc,
                                        selectedDate: selectedDate),
                                    flex: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Padding(
                              padding: EdgeInsets.all(5.sp),
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: cardBoxDecoration,
                                child: BlocProvider.value(
                                  value: BlocProvider.of<HistoryCubit>(context),
                                  child: RecentProgress(
                                    taskDoc: taskDoc,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      flex: 5,
                    ),
                  ],
                );
              }),
        );
      }),
    );
  }
}
