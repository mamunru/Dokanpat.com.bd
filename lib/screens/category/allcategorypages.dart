import 'package:dokanpat/configs/server.dart';
import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/mydrawer_controller.dart';
import 'package:dokanpat/widgets/images/network_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/allCategoryController.dart';
import '../../widgets/appbar/titleappbar.dart';

class AllCategoryPage extends StatefulWidget {
  const AllCategoryPage({super.key});

  @override
  State<AllCategoryPage> createState() => _AllCategoryPageState();
}

class _AllCategoryPageState extends State<AllCategoryPage> {
  int option = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Titleappbar(
          title: 'Categories',
        ),
      ),
      body: GetBuilder<MyDrawerController>(builder: (scontroller) {
        // init:
        // MyDrawerController().getcategory();
        return scontroller.catprogress.value
            ? Container(
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              )
            : Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                                padding: const EdgeInsets.only(top: 0),
                                itemCount:
                                    scontroller.categoypeoductslist.length,
                                itemBuilder: (_, index) {
                                  var item =
                                      scontroller.categoypeoductslist[index];
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        option = index;
                                      });
                                    },
                                    child: Card(
                                      child: Container(
                                        height: 100,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top: 0,
                                                child: Container(
                                                  child: Opacity(
                                                    opacity: .5,
                                                    child: NetworkCatchImage(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3,
                                                        imagekey: item.name,
                                                        image: item.src!.isEmpty
                                                            ? Server.noimage
                                                            : item.src
                                                                .toString(),
                                                        height: 100),
                                                  ),
                                                )),
                                            Center(
                                                child: Text(
                                              item.name.toString(),
                                              style: headerText2,
                                              textAlign: TextAlign.center,
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: MediaQuery.of(context).size.height,
                            child: scontroller.categoypeoductslist.isEmpty
                                ? Container()
                                : GridView.builder(
                                    padding: const EdgeInsets.only(top: 0),
                                    itemCount: scontroller
                                        .categoypeoductslist[option]
                                        .option!
                                        .length,
                                    itemBuilder: (_, op) {
                                      var item = scontroller
                                          .categoypeoductslist[option]
                                          .option![op];
                                      return InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                              '/product/category/${item.cid}',
                                              arguments: item);
                                        },
                                        child: Card(
                                          child: Container(
                                            height: 100,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                    top: 0,
                                                    child: Container(
                                                      child: Opacity(
                                                        opacity: .85,
                                                        child: NetworkCatchImage(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3,
                                                            imagekey: item.name,
                                                            image: item.src!
                                                                    .isEmpty
                                                                ? Server.noimage
                                                                : item.src
                                                                    .toString(),
                                                            height: 125),
                                                      ),
                                                    )),
                                                Center(
                                                    child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    item.name.toString(),
                                                    style: headerText2,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 5,
                                            childAspectRatio: 1
                                            //mainAxisExtent: 256,
                                            ),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //     top: 0,
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(top: 25),
                  //       child: Titleappbar(
                  //         title: 'Categories',
                  //       ),
                  //     )),
                  Positioned(
                      bottom: 10,
                      child: Visibility(
                        visible: scontroller.catprogress.value,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          child: const Center(
                              child: CircularProgressIndicator(
                            color: Colors.red,
                          )),
                        ),
                      ))
                ],
              );
      }),
    );
  }
}
