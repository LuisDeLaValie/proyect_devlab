import 'package:flutter/material.dart';

var colorA = const Color(0xff282a36);
var colorB = const Color(0xff42414d);
var colorC = const Color(0xffF8F8F2);
var colorD = const Color(0xff44475A);

var themaOscuro = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Color(0xff44475A),
    elevation: 0,
    titleTextStyle: TextStyle(color: Color(0xffF8F8F2)),
  ),
  scaffoldBackgroundColor: const Color(0xff282a36),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xff282a36),
    onPrimary: Color(0xff42414d),
    primaryContainer: Color(0xff282a36),
    onPrimaryContainer: Color(0xff42414d),
  ),
);
