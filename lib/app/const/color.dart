// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const clr_primary = Color(0XFF8332A6);
const clr_secondary = Color(0XFFBF2C98);
const clr_background = Color(0XFFFBF2FF);
Color clr_grey = Colors.grey;

ThemeData lightTheme = ThemeData(
  primaryColor: clr_primary,
  scaffoldBackgroundColor: clr_background,
  iconTheme: IconThemeData(color: clr_primary),
  buttonTheme: ButtonThemeData(
    buttonColor: clr_primary,
    textTheme: ButtonTextTheme.normal,
  ),
  backgroundColor: clr_background,
  primarySwatch: Colors.purple,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 16),
    systemOverlayStyle: SystemUiOverlayStyle.light,
    backgroundColor: clr_background,
    iconTheme: IconThemeData(color: clr_primary, size: 30),
  ),
);
