import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/sign_up_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/screens/login_layout.dart';
import 'package:todo_app/tabs/widgets/custom_text_form_field.dart';

import '../shared/styles/app_colors.dart';

class SignUpLayout extends StatelessWidget {
  static const String routeName = "SignUpLayout";

  const SignUpLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpProvider(),
      builder: (context, child) {
        var signUpProvider = Provider.of<SignUpProvider>(context);
        /*if(signUpProvider.responseCode == "200"){
          Navigator.pop(context);
        }*/
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                if (signUpProvider.isLoading)
                  const Center(child: CircularProgressIndicator()),
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Form(
                            key: signUpProvider.formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.sign_up, //
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 30),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextFormField(
                                  onChange: (value) {
                                    // final RegExp nameRegExp =
                                    //     RegExp(r'^[a-zA-Z]+$');
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .enter_name;
                                    }
                                    // if (!nameRegExp.hasMatch(value)) {
                                    //   return AppLocalizations.of(context)!
                                    //       .enter_valid_name;
                                    // }
                                    signUpProvider.setName(value);
                                    return null;
                                  },
                                  icon: Icons.person,
                                  obscureText: false,
                                  hintText:
                                      Text(AppLocalizations.of(context)!.name),
                                ),

                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextFormField(
                                  onChange: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .enter_age;
                                    }
                                    var age = num.tryParse(value);
                                    if (num.tryParse(value) == null) {
                                      return AppLocalizations.of(context)!
                                          .enter_valid_age;
                                    }
                                    if (age! <= 18) {
                                      return AppLocalizations.of(context)!
                                          .age_greater;
                                    }
                                    if (age >= 60) {
                                      return AppLocalizations.of(context)!
                                          .age_less;
                                    }
                                    signUpProvider
                                        .setAge(num.parse(value).toInt());
                                    return null;
                                  },
                                  icon: Icons.password,
                                  obscureText: false,
                                  hintText:
                                      Text(AppLocalizations.of(context)!.age),
                                ),

                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextFormField(
                                  onChange: (value) {
                                    final RegExp emailRegExp = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.com+");
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .enter_mail;
                                    }
                                    if (!emailRegExp.hasMatch(value)) {
                                      return AppLocalizations.of(context)!
                                          .enter_valid_mail;
                                    }
                                    signUpProvider.setEmail(value);
                                    return null;
                                  },
                                  icon: Icons.email,
                                  obscureText: false,
                                  hintText:
                                      Text(AppLocalizations.of(context)!.email),
                                ),
                                //
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextFormField(
                                  onChange: (value) {
                                    final RegExp passwordRegExp1 =
                                        RegExp(r"^(?=.*[A-Z])");
                                    final RegExp passwordRegExp2 =
                                        RegExp(r"^(?=.*[a-z])");
                                    final RegExp passwordRegExp3 =
                                        RegExp(r"^(?=.*?[0-9])");
                                    final RegExp passwordRegExp4 =
                                        RegExp(r"^(?=.*?[0-9])");
                                    final RegExp passwordRegExp5 =
                                        RegExp(r"^.{8,}");
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .enter_pass;
                                    }
                                    if (!passwordRegExp1.hasMatch(value)) {
                                      return AppLocalizations.of(context)!
                                          .valid_pass1;
                                    }
                                    if (!passwordRegExp2.hasMatch(value)) {
                                      return AppLocalizations.of(context)!
                                          .valid_pass2;
                                    }
                                    if (!passwordRegExp3.hasMatch(value)) {
                                      return AppLocalizations.of(context)!
                                          .valid_pass3;
                                    }
                                    if (!passwordRegExp4.hasMatch(value)) {
                                      return AppLocalizations.of(context)!
                                          .valid_pass4;
                                    }
                                    if (!passwordRegExp5.hasMatch(value)) {
                                      return AppLocalizations.of(context)!
                                          .valid_pass5;
                                    }
                                    signUpProvider.setPassword(value);
                                    return null;
                                  },
                                  visibilityIcon: IconButton(
                                    icon: Icon(
                                      signUpProvider.isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      signUpProvider.changeVisibility();
                                    },
                                  ),
                                  icon: Icons.lock,
                                  obscureText: !signUpProvider.isObscure,
                                  hintText: Text(
                                      AppLocalizations.of(context)!.password),
                                ),

                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    AppColors.primaryColor)),
                                        onPressed: () {
                                          if (signUpProvider
                                              .formKey.currentState!
                                              .validate()) {
                                            signUpProvider.signUp(
                                                onSuccess: () {
                                              Navigator.pop(context);
                                            }, onError: (message) {
                                              showSnackbar(context, message);
                                            });
                                          }
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .create_acc,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.have_acc,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.grey, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, LoginLayout.routeName);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
