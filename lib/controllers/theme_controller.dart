import 'package:dokanpat/configs/key_value.dart';
import 'package:dokanpat/configs/themes/app_light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/themes/app_dark_theme.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  late ThemeData _darkTheme;
  late ThemeData _lightTheme;
  final _box = GetStorage();
  final _key = 'isDeakMode';
  var test = "".obs;
  late bool gender;

  var color = Colors.transparent.obs;

  void onInit() {
    initializedThemeData();
    //color.val(Colors.transparent);
    super.onInit();
  }

  initializedThemeData() async {
    _darkTheme = DarkTheme().buildDarkTheme();
    _lightTheme = LightTheme().buildLightTheme();
    gender = loadThemeFromBox() ? true : false;
  }

  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;

  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);
  bool loadThemeFromBox() => _box.read(_key) ?? false;
  ThemeMode get theme => loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  genderChange() async {
    Get.changeThemeMode(loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!loadThemeFromBox());
    gender = loadThemeFromBox() ? true : false;

    print(gender);
    update();
  }
}
