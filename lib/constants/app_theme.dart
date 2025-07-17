

import 'package:flutter/material.dart';

enum AppTheme{
  LightTheme,
  DarkTheme
}


const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);



final AppThemeData = {
  AppTheme.LightTheme: ThemeData(
    primarySwatch: white,
    primaryColor: Colors.black,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    dividerColor: Colors.white54,
     fontFamily: 'Cairo', 
    

  ),

  AppTheme.DarkTheme: ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Color.fromARGB(255, 255, 255, 255),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color.fromARGB(255, 41, 41, 41),
    
    dividerColor: Colors.black12,
     fontFamily: 'Cairo', 
  )
};