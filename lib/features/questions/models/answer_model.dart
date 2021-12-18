class AnswerModel {
  String? answer;
  DateTime? date;
  String? uid;
  String? photoUrl;

  AnswerModel({
    this.answer,
    this.date,
    this.uid,
    this.photoUrl,
  });

  AnswerModel.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    date = json['date'];
    uid = json['uid'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer'] = answer;
    data['date'] = date;
    data['uid'] = uid;
    data['photoUrl'] = photoUrl;
    return data;
  }
}
