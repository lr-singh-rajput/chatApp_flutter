
import 'package:chatapp/Config/Colors.dart';
import 'package:flutter/material.dart';

var lightTheme = ThemeData();
var darkTheme =  ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: dContainerColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: dPrimarColor,
    filled: true,
  ),

  colorScheme: ColorScheme.dark(
      primary: dPrimarColor,
      onPrimary: dOnBackgroundColor,
      background: dBackgroundColor,
    onBackground: dOnBackgroundColor,
    primaryContainer:  dContainerColor,
    onPrimaryContainer: dOnContainerColor
  ),


  //Text themes
  textTheme:TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      color: dPrimarColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w800,
    ),

    headlineMedium: const TextStyle(
      fontSize: 30,
      color: dOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
    ),

    headlineSmall: const TextStyle(
      fontSize: 20,
      color: dOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
    ),

    labelLarge: const TextStyle(
      fontSize: 15,
      color: dOnContainerColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
    ),
    labelMedium: const TextStyle(
      fontSize: 12,
      color: dOnContainerColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      color: dPrimarColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w300,
    ),
    bodyLarge: const TextStyle(
      fontSize: 30,
      color: dOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: const TextStyle(
      fontSize: 16,
      color: dOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w500,
    ),

  )
);