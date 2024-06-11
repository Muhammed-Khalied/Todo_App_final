import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/main_provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/screens/edit_layout.dart';
import 'package:todo_app/screens/forget_password.dart';
import 'package:todo_app/screens/home_layout.dart';
import 'package:todo_app/screens/login_layout.dart';
import 'package:todo_app/screens/sign_up_layout.dart';
import 'package:todo_app/shared/styles/my_themes.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork(); //to make it local
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => TaskProvider()),
    ChangeNotifierProvider(create: (context) => MainProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainProvider>(context);
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
      locale: provider.locale,
      darkTheme: MyThemeData.darkThemeData,
      theme: MyThemeData.lightThemeData,
      themeMode: provider.themeMode,
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? LoginLayout.routeName
          : HomeLayout.routeName,
      routes: {
        SignUpLayout.routeName: (context) => SignUpLayout(),
        ForgetPassword.routeName: (context) => ForgetPassword(),
        LoginLayout.routeName: (context) => const LoginLayout(),
        HomeLayout.routeName: (context) => const HomeLayout(),
        EditLayout.routeName: (context) => const EditLayout(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
