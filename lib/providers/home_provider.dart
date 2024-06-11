import 'package:flutter/material.dart';
import 'package:todo_app/tabs/settings_tab.dart';
import 'package:todo_app/tabs/tasks_tab.dart';

class HomeProvider extends ChangeNotifier {
  int index = 0;
  List<Widget> tabs = [const TasksTab(), const SettingsTab()];

  void selectTap(int tabIndex) {
    index = tabIndex;
    notifyListeners();
  }
}
