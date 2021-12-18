import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/colors.dart';

TextEditingController todoController = TextEditingController();

class AddTodo extends StatelessWidget {
  const AddTodo({Key? key, this.onChoosed, required this.taskDoc})
      : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;

  final void Function(int feelingIndex)? onChoosed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "add your task",
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(
            height: 5.h,
          ),
          SizedBox(
            height: 10.h,
            width: 35.w,
            child: TextField(
              autofocus: true,
              controller: todoController,
              decoration: const InputDecoration(
                hintText: "Enter your task",
                hintStyle: TextStyle(color: YounminColors.primaryColor),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}
