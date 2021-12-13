import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:younmin/logic/helping_functions.dart';

part 'yearly_todo_state.dart';

List<QueryDocumentSnapshot<Map<String, dynamic>>> initState = [];

class YearlyTodoCubit extends Cubit<YearlyTodoState> {
  YearlyTodoCubit() : super(YearlyTodoState(yearlyTodoDocs: initState));
  FilePickerResult? result;

  void getYearlyTodo() async {
    final userData = await getUserData();
    final yearlyTodo = await userData.docs.first.reference
        .collection("yearlyTodo")
        .orderBy("createdAt")
        .get();

    emit(YearlyTodoState(yearlyTodoDocs: yearlyTodo.docs));
  }

  void createNewYearlyTodo(context,
      {required TextEditingController goalController, required feeling}) async {
    final userData = await getUserData();

    await userData.docs.first.reference.collection("yearlyTodo").add({
      "feeling": feeling,
      "goal": goalController.text,
      "progress": {"monthly": 0, "yearly": 0},
      "createdAt": DateTime.now(),
    });

    final docs = await userData.docs.first.reference
        .collection("yearlyTodo")
        .orderBy("createdAt")
        .get();

    emit(YearlyTodoState(yearlyTodoDocs: docs.docs));
    goalController.clear();
    Navigator.pop(context);
  }

  void updateYearlyTodo(context,
      {required TextEditingController goalController,
      required feeling,
      required QueryDocumentSnapshot<Map<String, dynamic>> doc}) async {
    await doc.reference.update({
      "feeling": feeling,
      "goal": goalController.text,
    });
    Navigator.pop(context);
    goalController.clear();
    getYearlyTodo();
  }

  void deleteYearlyTodo(context,
      {required QueryDocumentSnapshot<Map<String, dynamic>> doc}) async {
    await doc.reference.delete();
    Navigator.pop(context);
    getYearlyTodo();
  }

  void saveFeeling(context, {required feelingNumber}) async {
    final userData = await getUserData();
    userData.docs.first.reference.collection("feelings").add({
      "feeling": feelingNumber,
      "date": DateTime.now(),
    });
    Navigator.pop(context);
  }

  void uploadImage() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      final file = result!.files.single;

      // function called
      await saveImageIntoDatabase(file);
      emit(state.copyWith(imageFile: file.bytes));
    }
  }

  Future<void> saveImageIntoDatabase(PlatformFile? imageFile) async {
    // getting authenticated user instance
    FirebaseAuth _auth = FirebaseAuth.instance;
    final ref = FirebaseStorage.instance
        .ref("${_auth.currentUser!.uid}/profile.${imageFile!.extension}");
    final task = ref.putData(imageFile.bytes!);

    // uploading new profile picture
    task.then((uploadedTask) async {
      final photoUrl = await uploadedTask.ref.getDownloadURL();
      await _auth.currentUser!.updatePhotoURL(photoUrl);
    });
  }
}
