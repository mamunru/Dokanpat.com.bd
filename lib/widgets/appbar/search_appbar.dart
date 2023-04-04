import 'package:flutter/material.dart';
import '../../configs/themes/custome_text_style.dart';
import '../../controllers/mydrawer_controller.dart';
import '../../controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../screens/menu/menu_screen.dart';
import '../app_circle_button.dart';

class SearchAppbar extends GetView<MyDrawerController> {
  SearchAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      //color: controller.color.value,
      color: Colors.white,
      child: Container(
        //padding: const EdgeInsets.only(top: 30),
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: const FaIcon(
                  FontAwesomeIcons.bars,
                  size: 30,
                  color: Colors.black,
                )),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: (() {
                Get.toNamed(
                  '/search',
                );
              }),
              child: Container(
                margin: const EdgeInsets.only(left: 5, bottom: 1),
                width: MediaQuery.of(context).size.width * .78,
                height: 35,
                decoration: BoxDecoration(
                    color: Color.fromARGB(150, 230, 227, 227),
                    //border: Border.all(width: 1)
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: const [
                    SizedBox(
                      width: 10,
                    ),
                    FaIcon(FontAwesomeIcons.magnifyingGlass),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Search Here ',
                      style: detailText18,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
