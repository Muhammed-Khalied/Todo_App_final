import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../shared/network/remote/firebase_functions.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];

  DateTime selectedDate = DateUtils.dateOnly(DateTime.now());

  void selectDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  List<DateTime> holidays = [
    DateTime(2024, 1, 2),
    DateTime(2024, 6, 1),
    DateTime(2024, 9, 25),
    DateTime(2024, 10, 6),
    DateTime(2024, 10, 23)
  ];

  Future<void> addTask(TaskModel task) {
    return FirebaseFunctions.addTask(task);
  }

  Stream<QuerySnapshot<TaskModel>> getTasksSnapShot() {
    //Future => one-time read
    return FirebaseFunctions.getTasks(selectedDate.millisecondsSinceEpoch);
  }

  void getTasks(AsyncSnapshot<QuerySnapshot<TaskModel>> snapshot) {
    tasks = snapshot.data?.docs.map((doc) {
          TaskModel task = doc.data();
          task.id = doc.id;
          return task;
        }).toList() ??
        [];
    notifyListeners();
  }

  Future<void> removeTask(String id) {
    return FirebaseFunctions.deleteTask(id);
  }

  Future<void> doneTask(TaskModel task) {
    task.status = true;
    return FirebaseFunctions.updateTask(task);
  }

  Future<void> editTask(TaskModel task) {
    return FirebaseFunctions.updateTask(task);
  }


}
