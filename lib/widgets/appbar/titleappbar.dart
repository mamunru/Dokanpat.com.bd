import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../configs/themes/custome_text_style.dart';
import '../../controllers/cartController.dart';

class Titleappbar extends StatelessWidget {
  String title;
  Titleappbar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        //color: Colors.white,
        //margin: const EdgeInsets.only(top: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const BackButton(),
            // const SizedBox(
            //   width: 10,
            // ),
            Container(
                width: MediaQuery.of(context).size.width * .56,
                height: 40,
                alignment: Alignment.center,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(5),
                //  // color: Color.fromARGB(195, 172, 169, 169),
                // ),
                child: Center(
                    child: Text(
                  title,
                  style: headerText3,
                ))),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                width: 50,
                child: GetBuilder<CartController>(builder: (cartcontroller) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed('shopping/cart');
                    },
                    child: Stack(
                      children: [
                        Positioned(
                            top: -2,
                            left: 5,
                            child: Container(
                                height: 20,
                                width: 60,
                                // decoration: BoxDecoration(
                                //     color: Color.fromARGB(77, 228, 143, 143)),
                                child: Text(
                                  cartcontroller.cartlist.length.toString(),
                                  style: headerText4.copyWith(
                                      fontSize: 14, color: Colors.red),
                                ))),
                        const Center(
                          child: FaIcon(
                            FontAwesomeIcons.cartShopping,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
