import 'package:dokanpat/configs/themes/app_dark_theme.dart';
import 'package:dokanpat/configs/themes/app_light_theme.dart';
import 'package:dokanpat/configs/themes/ui_parameter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color onSurfaceTextColor = Colors.black;

const mainGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [PrimaryLightColorLight, PrimaryColorLight]);

const mainGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [PrimarydarkColordark, PrimaryColordark]);

LinearGradient mainGradient() =>
    UIparamenters.isDarkMode() ? mainGradientDark : mainGradientLight;

customeScaffoldColor(BuildContext context) => UIparamenters.isDarkMode()
    ? Color.fromRGBO(20, 45, 150, 1)
    : const Color.fromARGB(255, 240, 237, 255);

const List<Color> Colorbank = [
  Color.fromARGB(255, 220, 254, 253),
  Color.fromARGB(255, 254, 221, 206),
  Color.fromARGB(255, 251, 254, 223),
  Color.fromARGB(255, 255, 200, 255),
  Color.fromARGB(255, 209, 202, 248),
  Color.fromARGB(255, 191, 245, 231),
  Color.fromARGB(255, 240, 237, 255),
  Color.fromARGB(255, 240, 237, 255),
  Color.fromARGB(255, 240, 237, 255),
  Color.fromARGB(255, 240, 237, 255),
  Color.fromARGB(255, 240, 237, 255),
  Color.fromARGB(255, 240, 237, 255),
  Color.fromARGB(255, 240, 237, 255),
  Color.fromARGB(255, 240, 237, 255)
];

const Color specialTextColor = Color.fromARGB(255, 83, 0, 63);
