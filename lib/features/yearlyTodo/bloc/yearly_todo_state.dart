part of 'yearly_todo_cubit.dart';

class YearlyTodoState {
  YearlyTodoState({required this.yearlyTodoDocs, this.imageFile});
  final Uint8List? imageFile;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> yearlyTodoDocs;

  YearlyTodoState copyWith(
      {List<QueryDocumentSnapshot<Map<String, dynamic>>>? yearlyTodoDocs,
      Uint8List? imageFile}) {
    return YearlyTodoState(
        yearlyTodoDocs: yearlyTodoDocs ?? this.yearlyTodoDocs,
        imageFile: imageFile ?? this.imageFile);
  }
}
