import 'package:dokanpat/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/themes/custome_text_style.dart';
import '../controllers/theme_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenderButton extends StatelessWidget {
  GenderButton({Key? key}) : super(key: key);

  late bool gender;

  @override
  Widget build(BuildContext context) {
    ThemeController _themeController = Get.find();

    return Material(
      child: Container(
        color: Colors.white,
        child: GetBuilder<ThemeController>(
          // color: Colors.white,

          builder: (controller) => Row(
            children: [
              const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: FaIcon(
                    FontAwesomeIcons.venusMars,
                    size: 20,
                  )),

              Expanded(
                  child: Text(
                      controller.loadThemeFromBox()
                          ? "Gender (Female)"
                          : 'Gender (Male)',
                      style: profileTitle)),

              Switch(
                onChanged: (bool value) {
                  // print(value);
                  // ThemeService().switchTheme();
                  controller.genderChange();
                },
                value: controller.loadThemeFromBox(),
                activeColor: Color.fromARGB(255, 233, 30, 99),
                activeTrackColor: Color.fromARGB(255, 3, 8, 7),
                inactiveThumbColor: Colors.red,
                inactiveTrackColor: Color.fromARGB(255, 10, 1, 5),
              ),

              //Slider(value: 1, onChanged: )
            ],
          ),
        ),
      ),
    );
  }
}
