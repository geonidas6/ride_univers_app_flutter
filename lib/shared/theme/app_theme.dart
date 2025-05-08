import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static const _primaryColor = Color(0xFF2196F3);
  static const _secondaryColor = Color(0xFF03A9F4);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: _primaryColor,
    colorScheme: ColorScheme.light(
      primary: _primaryColor,
      secondary: _secondaryColor,
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        color: Colors.black87,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: _primaryColor,
    colorScheme: ColorScheme.dark(
      primary: _primaryColor,
      secondary: _secondaryColor,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        color: Colors.white70,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        color: Colors.white70,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF121212),
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
  );
}
