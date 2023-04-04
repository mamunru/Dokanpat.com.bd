import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double _mobileScreenPadding = 10.0;
const double _cardBroderRadius = 10.0;

double get mobileScreenPadding => _mobileScreenPadding;
double get mobileScreenPassing => _mobileScreenPadding;
double get cardBroderRadius => _cardBroderRadius;

class UIparamenters {
  static BorderRadius get cardBroderRadius =>
      BorderRadius.circular(_cardBroderRadius);
  static EdgeInsets get mobileScreenPassing =>
      const EdgeInsets.all(_mobileScreenPadding);

  static bool isDarkMode() {
    return Get.isDarkMode ? true : false;
  }
}
