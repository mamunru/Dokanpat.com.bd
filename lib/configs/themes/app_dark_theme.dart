import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/configs/themes/sub_theme_data_mixing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color PrimarydarkColordark = Color.fromARGB(255, 240, 241, 245);
const Color PrimaryColordark = Color.fromARGB(255, 233, 30, 99);

const Color mainTextColor = Color.fromARGB(255, 0, 0, 0);
const Color focusColor = Color.fromARGB(255, 233, 30, 99);

class DarkTheme with SubthemeData {
  buildDarkTheme() {
    final ThemeData systemDarkTheme = ThemeData.light();
    return systemDarkTheme.copyWith(
      iconTheme: getIconTheme(),
      appBarTheme: const AppBarTheme(
        elevation: 0,

        // titleTextStyle: headerText2,
        color: Colors.transparent,
        titleTextStyle: TextStyle(fontSize: 18, color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          // statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      scaffoldBackgroundColor: Color.fromARGB(255, 247, 248, 246),
      bottomAppBarColor: Color.fromARGB(255, 247, 248, 246),
      primaryColor: PrimaryColordark,
      highlightColor: mainTextColor,
      focusColor: focusColor,
      // textTheme: getTextThemes().apply(
      //     bodyColor: mainTextColor,
      //     displayColor: mainTextColor,
      //     fontFamily: 'Roboto'
      //     )
    );
  }
}
