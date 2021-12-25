// ignore: implementation_imports
import 'package:after_layout/after_layout.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/features/login/bloc/login_cubit.dart';
import 'package:younmin/features/yearlyTodo/bloc/yearly_todo_cubit.dart';
import 'package:younmin/features/yearlyTodo/widgets/add_yearly_todo_dialog.dart';
import 'package:younmin/features/yearlyTodo/widgets/yearly_todo_tile.dart';
import 'package:younmin/globals/Strings/global_strings.dart';
import 'package:younmin/globals/Strings/yearlyTodo_page_strings.dart';
import 'package:younmin/globals/YounminWidgets/capsule_button.dart';
import 'package:younmin/globals/YounminWidgets/choose_feeling.dart';
import 'package:younmin/globals/YounminWidgets/logo_button.dart';
import 'package:younmin/globals/colors.dart';

Future<User?> getUser() async {
  await Future.delayed(const Duration(seconds: 1));
  return FirebaseAuth.instance.currentUser;
}

class YearlyTodo extends StatefulWidget {
  const YearlyTodo({Key? key, this.fistLogin = false}) : super(key: key);
  final bool fistLogin;

  @override
  State<YearlyTodo> createState() => _YearlyTodoState();
}

class _YearlyTodoState extends State<YearlyTodo>
    with AfterLayoutMixin<YearlyTodo> {
  bool showMenu = true;
  @override
  Widget build(BuildContext context) {
    YearlyTodoCubit().getYearlyTodo();
    var user = FirebaseAuth.instance.currentUser;

    return BlocProvider<YearlyTodoCubit>(
      create: (BuildContext context) => YearlyTodoCubit(),
      child: Builder(builder: (context) {
        BlocProvider.of<YearlyTodoCubit>(context).getYearlyTodo();
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: YounminColors.secondaryColor,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext _) {
                    return BlocProvider.value(
                        child: const AddYearlyTodo(),
                        value: BlocProvider.of<YearlyTodoCubit>(context));
                  });
            },
            child: const FaIcon(
              FontAwesomeIcons.plus,
              color: YounminColors.primaryColor,
            ),
          ),
          body: FutureBuilder(
              future: getUser(),
              builder: (context, AsyncSnapshot<User?> asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  if (asyncSnapshot.data != null) {
                    user = asyncSnapshot.data;
                    return Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            color: YounminColors.lightBlack,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: LogoButton(
                                    navigateOnTap: false,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          BlocBuilder<YearlyTodoCubit,
                                                  YearlyTodoState>(
                                              buildWhen: (preState, state) =>
                                                  state.imageFile != null,
                                              builder: (BuildContext context,
                                                  state) {
                                                return CircleAvatar(
                                                  backgroundImage:
                                                      (state.imageFile != null
                                                          ? MemoryImage(
                                                              state.imageFile!)
                                                          : NetworkImage(
                                                              user!.photoURL ??
                                                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/542px-Unknown_person.jpg",
                                                            )) as ImageProvider,
                                                  backgroundColor: YounminColors
                                                      .primaryColor,
                                                  radius: 70,
                                                );
                                              }),
                                          Positioned(
                                            bottom: 15,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: YounminColors
                                                    .lightGreyColor,
                                              ),
                                              child: IconButton(
                                                tooltip: YearlyTodoStrings
                                                    .editProfilePicture,
                                                iconSize: 20,
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  BlocProvider.of<
                                                              YearlyTodoCubit>(
                                                          context)
                                                      .uploadImage();
                                                },
                                                icon: const Icon(Icons.edit),
                                              ),
                                            ),
                                          ),
                                        ]),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Text(
                                      user!.displayName ?? " ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(
                                            color: YounminColors.secondaryColor,
                                          ),
                                    ),
                                  ],
                                ),
                                CapsuleButton(
                                  minHeight: 50,
                                  minWidth: 220,
                                  onPressed: () {
                                    BlocProvider.of<LoginCubit>(context)
                                        .logout(context);
                                  },
                                  buttonText: "Log out",
                                  //   style: Theme.of(context)
                                  //       .textTheme
                                  //       .bodyText1!
                                  //       .copyWith(fontSize: 20),
                                  // )
                                ),
                                const SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              headingOfList(),
                              Expanded(
                                child: listOfYearlyTodo(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                }
                return const Center(child: CircularProgressIndicator());
              }),
        );
      }),
    );
  }

  Widget headingOfList() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          YearlyTodoStrings.tasks,
          style: Theme.of(context).textTheme.headline4!.copyWith(
                fontSize: 24,
                color: YounminColors.secondaryColor,
              ),
        ),
      ),
    );
  }

  Widget listOfYearlyTodo() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: BlocBuilder<YearlyTodoCubit, YearlyTodoState>(
          builder: (BuildContext context, state) {
        return ImplicitlyAnimatedList(
          items: state.yearlyTodoDocs,
          itemBuilder: (BuildContext context, animation,
              QueryDocumentSnapshot<Map<String, dynamic>> item, int index) {
            return SizeFadeTransition(
              sizeFraction: 0.2,
              curve: Curves.easeInOut,
              animation: animation,
              child: BlocProvider.value(
                value: BlocProvider.of<YearlyTodoCubit>(context),
                child: YearlyTodoTile(
                  index: index,
                  item: item,
                ),
              ),
            );
          },
          // separatorBuilder: (BuildContext context, int index) =>
          //     SizedBox(
          //   height: 5.h,
          // ),
          areItemsTheSame: (QueryDocumentSnapshot<Map<String, dynamic>> oldItem,
                  QueryDocumentSnapshot<Map<String, dynamic>> newItem) =>
              oldItem['createdAt'] == newItem["createdAt"],

          removeItemBuilder: (context, animation,
              QueryDocumentSnapshot<Map<String, dynamic>> oldItem) {
            return FadeTransition(
              opacity: animation,
              child: BlocProvider.value(
                value: BlocProvider.of<YearlyTodoCubit>(context),
                child: YearlyTodoTile(
                  item: oldItem,
                ),
              ),
            );
          },
        );
      }),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.fistLogin) {
      AwesomeDialog(
              context: context,
              width: 60.w,
              dialogType: DialogType.QUESTION,
              headerAnimationLoop: false,
              animType: AnimType.BOTTOMSLIDE,
              body: Column(
                children: [
                  Text(
                    YearlyTodoStrings.welcomeBack,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 20),
                  ),
                  ChooseFeeling(
                    onChoosed: (feelingNumber) async => {
                      YearlyTodoCubit()
                          .saveFeeling(context, feelingNumber: feelingNumber)
                    },
                  ),
                ],
              ),
              btnOkText: YearlyTodoStrings.addCheck,
              btnCancelOnPress: () {})
          .show();
    }
  }
}
