import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/network/remote/firebase_functions.dart';

class LoginProvider extends ChangeNotifier{
  var formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String responseCode="";
  bool isObscure = false;
  bool isLoading = false;



  void startLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }

  void changeVisibility(){
    isObscure = !isObscure;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setPassword(String password) {
    this.password = password;
  }

  void login({required Function onSuccess,required Function onError}) async {
    try {
      await FirebaseFunctions.login(email.trim(), password.trim());
      isLoading = false;
      responseCode = "200";
      onSuccess();
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      responseCode = e.code;
      onError(responseCode.replaceAll("-", " "));
      notifyListeners();
      /*if (e.code == 'user-not-found') {
        responseCode = e.code;
        notifyListeners();
      } else if (e.code == 'wrong-password') {
        responseCode = e.code;
        notifyListeners();
      }*/
    }
  }

}