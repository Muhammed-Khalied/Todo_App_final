import 'package:flutter/material.dart';
import 'package:todo_app/shared/network/remote/firebase_functions.dart';

class BottomSheetProvider extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateUtils.dateOnly(DateTime.now());
  String title = "";
  String? currentUserId;

  void setTitle(String text) {
    title = text;
    notifyListeners();
  }

  void setInitialDate(DateTime initialDate) {
    selectedDate = initialDate;
    notifyListeners();
  }

  void selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      notifyListeners();
    }
  }

  void getCurrentUserId() {
    currentUserId = FirebaseFunctions.getCurrentUser()?.uid;
    notifyListeners();
  }
}
