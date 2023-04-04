import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/configs/themes/sub_theme_data_mixing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color PrimaryLightColorLight = Color.fromARGB(255, 174, 220, 223);
const Color PrimaryColorLight = Color(0xFFf85187);
const Color mainTextColor = Color.fromARGB(255, 40, 40, 40);
const Color cardColor = Color.fromARGB(255, 254, 254, 255);
const Color focusColor = Color(0xFFE53935);

class LightTheme with SubthemeData {
  buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
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
      primaryColor: PrimaryColorLight,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      iconTheme: getIconTheme(),
      cardColor: cardColor,
      focusColor: focusColor,
      primaryColorLight: mainTextColor,
      // textTheme: getTextThemes().apply(
      //   bodyColor: mainTextColor,
      //   displayColor: mainTextColor,
      //   //fontFamily: 'Roboto'
      // )
    );
  }
}
