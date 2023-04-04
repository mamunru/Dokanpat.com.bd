import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/mydrawer_controller.dart';
import 'package:dokanpat/controllers/theme_controller.dart';
import 'package:dokanpat/screens/home/message_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../configs/themes/app_colors.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          //width: MediaQuery.of(context).size.width * .75,
          //color: Color.fromARGB(0, 49, 175, 175),

          child: GetBuilder<MyDrawerController>(builder: (controller) {
            return SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,

                  //width: MediaQuery.of(context).size.width / 3,
                  padding: const EdgeInsets.only(top: 20, left: 10, bottom: 10),
                  child: Text(
                    'By Category'.toUpperCase(),
                    style: headerText3,
                  ),
                ),
                Column(
                  children: controller.categoypeoductslist
                      .asMap()
                      .entries
                      .map(
                        (e) => ExpansionTile(
                            title: Text(
                              e.value.name.toString(),
                              style: detailText16,
                            ),
                            children: e.value.option!
                                .asMap()
                                .entries
                                .map((optiondata) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: ExpansionTile(
                                  onExpansionChanged: (value) {
                                    if (optiondata.value.sub!.isEmpty) {
                                      Get.toNamed(
                                          '/product/category/${optiondata.value.cid}/${e.value.pid}',
                                          arguments: optiondata.value);
                                    } else {
                                      controller.Subindexupdate(
                                          value, optiondata.key, e.key);
                                    }
                                  },
                                  iconColor: Colors.red,
                                  collapsedIconColor: Colors.black,
                                  title: InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                          '/product/category/${optiondata.value.cid}/${e.value.pid}',
                                          arguments: optiondata.value!);
                                    },
                                    child: Text(
                                      optiondata.value.name.toString(),
                                      style: detailText15,
                                    ),
                                  ),
                                  trailing: optiondata.value.sub!.isEmpty
                                      ? Text('')
                                      : optiondata.value.show == 0
                                          ? FaIcon(
                                              FontAwesomeIcons.angleUp,
                                              size: 12,
                                            )
                                          : FaIcon(
                                              FontAwesomeIcons.angleDown,
                                              size: 12,
                                            ),
                                  children: [
                                    Visibility(
                                        visible:
                                            optiondata.value.sub!.isNotEmpty,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Column(
                                            children: optiondata.value.sub!
                                                .map((sub) => GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            '/product/category/${sub.child}/${optiondata.value.pid}',
                                                            arguments:
                                                                optiondata
                                                                    .value);
                                                      },
                                                      child: ListTile(
                                                        title: Text(sub.name
                                                            .toString()),
                                                      ),
                                                    ))
                                                .toList(),
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            }).toList()),
                      )
                      .toList(),
                )
              ],
            ));
          }),
        ),
      ),
    );
  }
}
