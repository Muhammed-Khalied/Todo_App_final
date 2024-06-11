// ignore_for_file: camel_case_types, must_be_immutable, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      this.hintText,
      required this.obscureText,
      this.onChange,
      this.controller,
      this.visibilityIcon,
      required this.icon});
  Widget? hintText;
  bool obscureText;
  String? Function(String?)? onChange;
  // Function(String)? onChange;
  IconData icon;
  Widget? visibilityIcon;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: TextFormField(
          // keyboardType: TextInputType.number,

          style: const TextStyle(
            color: Colors.black,
          ),
          controller: controller,

          validator: onChange,
          // (data) {
          //   if (data!.isEmpty) {
          //     return 'Try Again';
          //   }
          // },
          // onChanged: onChange,
          textAlign: TextAlign.start,
          obscureText: obscureText,
          decoration: InputDecoration(
              suffixIcon: visibilityIcon,
              prefixIcon: Icon(
                icon,
                color: Colors.black,
              ),
              label: hintText,
              hintStyle: const TextStyle(
                  // fontFamily: 'cairo',
                  color: Colors.black,
                  fontSize: 15),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                borderSide: BorderSide(color: Colors.black),
              ),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  borderSide: BorderSide(color: Colors.black))),
        ),
      ),
    );
  }
}
