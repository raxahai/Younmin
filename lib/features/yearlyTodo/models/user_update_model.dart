import 'package:flutter/foundation.dart';

class UserDataModel {
  final int age;
  final String uid;

  UserDataModel(this.age, this.uid);

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(json['age'], json['uid']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = age;
    data['uid'] = uid;
    return data;
  }
}
