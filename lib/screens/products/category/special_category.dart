import 'package:dokanpat/configs/themes/app_colors.dart';
import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/model/banner_model.dart';
import 'package:dokanpat/widgets/images/network_images.dart';
import 'package:dokanpat/widgets/images/special_banner_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/server.dart';

class SpecialCategories extends StatelessWidget {
  var Categories;
  double height;
  SpecialCategories({required this.height, required this.Categories, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: (Categories as List<Specialbanner>).map((e) {
                  return Visibility(
                    visible: e.size == 0 ? true : false,
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 5, bottom: 8, right: 5, left: 5),
                      height: height - 14,
                      child: GestureDetector(
                        onTap: () {
                          // print(2 * MediaQuery.of(context).size.width / 3 - 10);
                          switch (e.check) {
                            case 1:
                              Get.toNamed('/product/banner/${e.menu}',
                                  arguments: e.name);
                              break;
                            case 2:
                              print('tag');
                              Get.toNamed('/product/by/tag/${e.tag}',
                                  arguments: e.name);
                              break;
                            case 3:
                              Get.toNamed('/webview/${e.name}',
                                  arguments: e.product);
                              break;
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: NetworkCatchImage(
                            width:
                                2 * MediaQuery.of(context).size.width / 3 - 10,
                            imagekey: e.name,
                            image: e.src != null
                                ? '${Server.secondurl}/${e.src}'
                                : '${Server.noimage}',
                            height: height - 15,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              children: (Categories as List<Specialbanner>).map((e) {
                return Visibility(
                  visible: e.size == 1 ? true : false,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    margin: const EdgeInsets.only(top: 5, bottom: 8, right: 5),
                    height: height - 14,
                    child: GestureDetector(
                      onTap: () {
                        switch (e.check) {
                          case 1:
                            Get.toNamed('/product/banner/${e.menu}',
                                arguments: e.name);
                            break;
                          case 2:
                            Get.toNamed('/product/by/tag/${e.tag}',
                                arguments: e.name);
                            break;
                          case 3:
                            Get.toNamed('/webview/${e.name}',
                                arguments: e.product);
                            break;
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        //padding: const EdgeInsets.symmetric(vertical: 8),
                        child: NetworkCatchImage(
                            width: MediaQuery.of(context).size.width / 3,
                            imagekey: e.name,
                            image: e.src != null
                                ? '${Server.secondurl}/${e.src}'
                                : 'https://st3.depositphotos.com/23594922/31822/v/1600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg',
                            height: height - 15),
                      ),
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
