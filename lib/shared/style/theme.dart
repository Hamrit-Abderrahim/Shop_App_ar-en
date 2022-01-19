import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color.dart';
//0xFF
ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white, //satutsBar:هو الشريط العلوي لي فيه الوقت و البتري والريزو
        statusBarIconBrightness:
        Brightness.dark, //لون الايقونات في statusBar
      ),
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 22.0),
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0.0
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: MyColors.navy,
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      )),
  fontFamily: 'Jannah',
  primarySwatch: MyColors.navy,
);
