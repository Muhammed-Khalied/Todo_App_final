import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/shared/network/remote/firebase_functions.dart';

class SignUpProvider extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();
  String name = "";
  int age = 0;
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

  void setName(String name) {
    this.name = name;
  }

  void setAge(int age) {
    this.age = age;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setPassword(String password) {
    this.password = password;
  }

  void signUp({required Function onSuccess,required Function onError}) async{
    try {
      final credential = await FirebaseFunctions.signUp(email.trim(), password.trim());
      isLoading = false;
      responseCode = "200";
      UserModel user = UserModel(name: name, email: email, age: age);
      FirebaseFunctions.addUser(user, credential.user!.uid);
      onSuccess();
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      responseCode = e.code;
      onError(responseCode.replaceAll("-", " "));
      notifyListeners();
      /*if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        responseCode = e.code;
        notifyListeners();
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        responseCode = e.code;
        notifyListeners();
      }else if(e.code == "invalid-email"){
        print('The email is invalid.');
        responseCode = e.code;
        notifyListeners();
      }*/
    }
  }
}
