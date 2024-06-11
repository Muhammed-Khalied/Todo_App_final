// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/screens/login_layout.dart';
import 'package:todo_app/tabs/widgets/custom_text_form_field.dart';
import 'package:todo_app/tabs/widgets/error_alert_dailog.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  static const String routeName = 'Forget-Screen';

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _forgetPassTextController =
      TextEditingController(text: '');

  void _forgettPassSubmitForm() async {
    try {
      await _auth.sendPasswordResetEmail(email: _forgetPassTextController.text);
      Navigator.pushReplacementNamed(context, LoginLayout.routeName);
    } catch (error) {
      ErrorAlertDailog(message: error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Forget Password',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 30),
        CustomTextFormField(
          obscureText: true,
          controller: _forgetPassTextController,
          icon: Icons.email,
          hintText: const Text('Email Address'),
        ),
        const SizedBox(height: 40),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
        //   child: CustomButton(
        //     height: 50,
        //     fontsize: 20,
        //     onTap: () {
        //       _forgettPassSubmitForm();
        //     },
        //     text: 'Reset now',
        //   ),
        // ),
        GestureDetector(
          onTap: () {
            _forgettPassSubmitForm();
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            // height: 20,
            // width: 40,
            decoration: BoxDecoration(
                // color: color,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.black
                    //  Colors.white60
                    )),
            child: const Center(
              child: Text(
                'Reset now',
                style: TextStyle(
                    fontSize: 16,
                    // color: Colors.white,
                    fontFamily: 'cairo'),
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
        //   child: CustomButton(
        //     height: 50,
        //     fontsize: 20,
        //     onTap: () {
        //       Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        //     },
        //     text: ,
        //   ),
        // ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, LoginLayout.routeName);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            // height: 20,
            // width: 40,
            decoration: BoxDecoration(
                // color: color,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.black
                    //  Colors.white60
                    )),
            child: const Center(
              child: Text(
                ' Back',
                style: TextStyle(
                    fontSize: 16,
                    // color: Colors.white,
                    fontFamily: 'cairo'),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
