import 'package:flutter/material.dart';

var colorA = const Color(0xff282a36); // prymary
var colorB = const Color(0xff42414d); // on prymarycontainer
var colorC = const Color(0xffF8F8F2); // on prymary
var colorD = const Color(0xff44475A); // sencudary

var themaOscuro = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: colorA,
  appBarTheme: appBarTheme,
  textSelectionTheme: textSelectionTheme,
  textButtonTheme: textButtonTheme,
  textTheme: textTheme,
  inputDecorationTheme: inputDecorationTheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(primary: colorB, onPrimary: colorC,)),
);

var appBarTheme = AppBarTheme(
  color: colorD,
  elevation: 0,
  titleTextStyle: TextStyle(color: colorC),
);
var textSelectionTheme = TextSelectionThemeData(
  selectionColor: colorC.withOpacity(0.5),
  cursorColor: colorC,
);
var textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    primary: colorC,
    onSurface: colorB,
  ),
);
var textTheme = TextTheme(
  displayLarge: TextStyle(color: colorC),
  displayMedium: TextStyle(color: colorC),
  displaySmall: TextStyle(color: colorC),
  headlineLarge: TextStyle(color: colorC),
  headlineMedium: TextStyle(color: colorC),
  headlineSmall: TextStyle(color: colorC),
  titleLarge: TextStyle(color: colorC),
  titleMedium: TextStyle(color: colorC),
  titleSmall: TextStyle(color: colorC),
  bodyLarge: TextStyle(color: colorC),
  bodyMedium: TextStyle(color: colorC),
  bodySmall: TextStyle(color: colorC),
  labelLarge: TextStyle(color: colorC),
  labelMedium: TextStyle(color: colorC),
  labelSmall: TextStyle(color: colorC),
);
var inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: colorB,
  focusColor: colorC,
  labelStyle: TextStyle(color: colorC),
  contentPadding: const EdgeInsets.all(10),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: colorB, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(100.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: colorC, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(100.0)),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.redAccent, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(100.0)),
  ),
);

