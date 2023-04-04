import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/mydrawer_controller.dart';
import 'package:dokanpat/model/onscreensms_model.dart';
import 'package:dokanpat/widgets/images/network_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OnscreenDailog extends StatelessWidget {
  const OnscreenDailog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                Get.back();
                print(
                  MediaQuery.of(context).size.width * .80,
                );
              },
              child: const Padding(
                padding: const EdgeInsets.all(10.0),
                child: FaIcon(
                  FontAwesomeIcons.xmark,
                  size: 22,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
        body: GetBuilder<MyDrawerController>(builder: (controller) {
          return Container(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: ListView.builder(
                  itemCount: controller.onscreen.length,
                  itemBuilder: (_, index) {
                    onscreensmsModel e = controller.onscreen[index];
                    return Container(
                      padding: const EdgeInsets.all(5),
                      color: index.isEven
                          ? Color.fromARGB(122, 211, 208, 208)
                          : Colors.white,
                      height: e.image.toString().length > 10 ? 380 : 200,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Text(
                            e.title.toString(),
                            style: headerText2,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            child: RichText(
                                text: TextSpan(
                              text: e.message.toString(),
                              style: detailText16,
                              //overflow: TextOverflow.ellipsis,
                            )),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            //height: 500,
                            height: 250,
                            width: MediaQuery.of(context).size.width * 70,
                            child: Visibility(
                              visible:
                                  e.image.toString().length > 10 ? true : false,
                              child: NetworkCatchImage(
                                imagekey: e.image.toString(),
                                image: e.image.toString(),
                                height: 250,
                                width: MediaQuery.of(context).size.width * .70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }));
        }));
  }
}
