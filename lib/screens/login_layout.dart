import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/login_provider.dart';
import 'package:todo_app/screens/forget_password.dart';
import 'package:todo_app/screens/home_layout.dart';
import 'package:todo_app/screens/sign_up_layout.dart';

import '../shared/styles/app_colors.dart';

class LoginLayout extends StatelessWidget {
  static const String routeName = "AuthLayout";

  const LoginLayout({super.key});

  @override
  Widget build(BuildContext context) {
    /*if(FirebaseAuth.instance.currentUser!=null){
      Navigator.pushNamed(context, HomeLayout.routeName);
    }*/
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      builder: (context, child) {
        var loginProvider = Provider.of<LoginProvider>(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                if (loginProvider.isLoading)
                  const Center(child: CircularProgressIndicator()),
                Form(
                  key: loginProvider.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.login,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 50),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              validator: (value) {
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
                                loginProvider.setEmail(value);
                                return null;
                              },
                              decoration: InputDecoration(
                                label:
                                    Text(AppLocalizations.of(context)!.email),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: const BorderSide(
                                        color: AppColors.primaryColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: const BorderSide(
                                        color: AppColors.primaryColor)),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              obscureText: !loginProvider.isObscure,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .enter_pass;
                                }
                                loginProvider.setPassword(value);
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    loginProvider.isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    loginProvider.changeVisibility();
                                  },
                                ),
                                label: Text(
                                    AppLocalizations.of(context)!.password),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: const BorderSide(
                                        color: AppColors.primaryColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: const BorderSide(
                                        color: AppColors.primaryColor)),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ForgetPassword.routeName);
                                  },
                                  child: const Text('Forget Password'),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                AppColors.primaryColor)),
                                    onPressed: () {
                                      if (loginProvider.formKey.currentState!
                                          .validate()) {
                                        loginProvider.startLoading();
                                        loginProvider.login(onSuccess: () {
                                          Navigator.pushNamed(
                                              context, HomeLayout.routeName);
                                        }, onError: (message) {
                                          showSnackbar(context, message);
                                        });
                                        if (loginProvider.responseCode ==
                                            "200") {
                                          Navigator.pushNamed(
                                              context, HomeLayout.routeName);
                                        }
                                        print("valid");
                                      } else {
                                        print("invalid");
                                      }
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.login,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),

                            /*SizedBox(
                                width: MediaQuery.of(context).size.width * .5,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (loginProvider.formKey.currentState!
                                          .validate()) {
                                        loginProvider.startLoading();
                                        loginProvider.login(onSuccess: () {
                                          Navigator.pushNamed(
                                              context, HomeLayout.routeName);
                                        }, onError: (message) {
                                          showSnackbar(context, message);
                                        });
                                        if (loginProvider.responseCode ==
                                            "200") {
                                          Navigator.pushNamed(
                                              context, HomeLayout.routeName);
                                        }
                                        print("valid");
                                      } else {
                                        print("invalid");
                                      }
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.login))),*/

                            /*Text(
                              loginProvider.responseCode != "200" &&
                                      loginProvider.responseCode.isNotEmpty
                                  ? "*${loginProvider.responseCode.replaceAll("-", " ")}"
                                  : "",
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            )*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    AppLocalizations.of(context)!
                                        .do_not_have_acc,
                                    style:
                                        Theme.of(context).textTheme.bodySmall!
                                    // .copyWith(
                                    //     color: Colors.grey, fontSize: 14),
                                    ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, SignUpLayout.routeName);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.create_acc,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 14),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
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
