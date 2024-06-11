import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/shared/styles/app_colors.dart';

class MyThemeData {
  BuildContext context;

  MyThemeData(this.context);

  static ThemeData lightThemeData = ThemeData(
      brightness: Brightness.light,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.primaryColor,
        selectedLabelStyle: TextStyle(
            color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle:
            TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
      ),
      scaffoldBackgroundColor: AppColors.backgroundColor,
      primaryColor: AppColors.primaryColor,
      textTheme: TextTheme(
        bodySmall: GoogleFonts.cairo(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: AppColors.black),
        bodyMedium: GoogleFonts.cairo(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor),
        bodyLarge: GoogleFonts.cairo(
            fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black),
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          iconTheme: IconThemeData(color: AppColors.white, size: 30)));

  static ThemeData darkThemeData = ThemeData(
      brightness: Brightness.dark,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.primaryColor,
        selectedLabelStyle: TextStyle(
            color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle:
            TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
      ),
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      primaryColor: AppColors.primaryColor,
      textTheme: TextTheme(
        bodySmall: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: AppColors.white),
        bodyMedium: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor),
        bodyLarge: GoogleFonts.poppins(
            fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.black),
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          iconTheme: IconThemeData(color: AppColors.black, size: 30)));
}
