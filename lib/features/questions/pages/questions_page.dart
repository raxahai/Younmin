import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/features/questions/bloc/questions_cubit.dart';
import 'package:younmin/features/questions/pages/show_answers_page.dart';
import 'package:younmin/globals/YounminWidgets/app_bar.dart';
import 'package:younmin/globals/colors.dart';

final _auth = FirebaseAuth.instance;

class Questions extends StatelessWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => QuestionsCubit(),
      child: Builder(builder: (context) {
        BlocProvider.of<QuestionsCubit>(context).getQuestions();
        return Scaffold(
          appBar: CustomAppBarWithBackActionButton(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Questions: ",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: YounminColors.secondaryColor),
                ),
                Expanded(
                  child: Container(
                    color: YounminColors.backGroundColor,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: BlocBuilder<QuestionsCubit, QuestionsState>(
                          buildWhen: (oldState, state) =>
                              state.questionDocs != null,
                          builder: (context, state) {
                            return ImplicitlyAnimatedList(
                              items: state.questionDocs!,
                              itemBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  QueryDocumentSnapshot<Map<String, dynamic>>
                                      item,
                                  int index) {
                                return SizedBox(
                                  height: 85,
                                  child: Card(
                                    child: ListTile(
                                      onTap: () {
                                        showModalBottomSheet<dynamic>(
                                          backgroundColor:
                                              YounminColors.lightBlack,
                                          shape: RoundedRectangleBorder(
                                            //the rounded corner is created here
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5.sp),
                                                topRight:
                                                    Radius.circular(5.sp)),
                                          ),
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (_) => BlocProvider.value(
                                            value:
                                                BlocProvider.of<QuestionsCubit>(
                                                    context),
                                            child: Answers(questionDoc: item),
                                          ),
                                        );
                                      },
                                      title: Text(
                                        item['title'],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text(
                                        item['body'],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              areItemsTheSame:
                                  (QueryDocumentSnapshot<Map<String, dynamic>>
                                              oldItem,
                                          QueryDocumentSnapshot<
                                                  Map<String, dynamic>>
                                              newItem) =>
                                      oldItem['title'] == newItem['title'],
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
