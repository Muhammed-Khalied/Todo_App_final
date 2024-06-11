// ignore_for_file: constant_identifier_names

import 'package:intl/intl.dart';

class TaskModel {
  static const String COLLECTION_NAME = "Tasks";
  String id, title, userId;
  int date;
  bool status;

  TaskModel(
      {this.id = "",
      required this.userId,
      required this.date,
      required this.title,
      required this.status});

  TaskModel.fromJSON(Map<String, dynamic> json)
      : this(
          //id: json['id'],
          userId: json['user_id'],
          date: json['date'],
          title: json['title'],
          status: json['status'],
        );

  Map<String, dynamic> toJSON() {
    return {
      //"id": id,
      "user_id": userId,
      "date": date,
      "title": title,
      "status": status,
    };
  }

  String getDate() {
    DateTime datetime = DateTime.fromMillisecondsSinceEpoch(date);
    String formattedDate = DateFormat('yyyy-MM-dd').format(datetime);
    return formattedDate;
  }
}
