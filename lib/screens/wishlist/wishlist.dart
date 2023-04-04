import 'dart:math';

import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/wishliatController.dart';
import 'package:dokanpat/widgets/empty_page.dart';
import 'package:dokanpat/widgets/images/network_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Wishlist extends StatelessWidget {
  Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Wishlist'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: GetBuilder<WishListController>(builder: (wishlistcontroller) {
            return wishlistcontroller.wishlistproduct.length == 0
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    child: EmptyPage(title: 'No Product in Your Wishlist !!'))
                : Column(
                    children: wishlistcontroller.wishlistproduct
                        .map((element) => Card(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListTile(
                                  leading: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                          '/product_details/online/${element.id}/${element.categories![0].id}',
                                          arguments: element);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      child: NetworkCatchImage(
                                        imagekey: element.images![0].name,
                                        image: element.images![0].src!,
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                  ),
                                  title: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            '/product_details/online/${element.id}/${element.categories![0].id}',
                                            arguments: element);
                                      },
                                      child: Text(
                                        element.name.toString(),
                                        style: detailText16.copyWith(
                                            color: Colors.black),
                                      )),
                                  subtitle: Text(
                                    'Price = ' +
                                        element.price.toString() +
                                        'TK',
                                    style: detailText16.copyWith(
                                        color: Colors.red),
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      wishlistcontroller.deleteMethod(element);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: FaIcon(
                                        FontAwesomeIcons.trash,
                                        color: Colors.red,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).focusColor,
        onPressed: () {
          Get.back();
        },
        child: const FaIcon(FontAwesomeIcons.angleLeft),
      ),
    );
  }
}
