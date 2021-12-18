class QuestionsModel {
  String? title;
  String? body;

  QuestionsModel({this.title, this.body});

  QuestionsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }
}
