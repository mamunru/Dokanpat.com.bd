// ignore_for_file: depend_on_referenced_packages, unnecessary_import

import 'package:dokanpat/configs/server.dart';
import 'package:dokanpat/controllers/token_controller.dart';
import 'package:dokanpat/widgets/images/network_images.dart';
import 'package:dokanpat/widgets/progress/shimmer_prograss.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageSlider extends StatefulWidget {
  double height;

  ImageSlider(this.height, {Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TokenController>(
      builder: (controller) {
        return controller.bannerprogrss
            ? Scaffold(
                body: ShimmerProgress(),
              )
            : Scaffold(
                body: Stack(
                children: [
                  CarouselSlider(
                      carouselController: _controller,
                      options: CarouselOptions(
                          height: widget.height,
                          viewportFraction: 1.0,
                          initialPage: _current,
                          enableInfiniteScroll: true,
                          //reverse: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          // onPageChanged: callbackFunction,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                      items: controller.banner.mainbanner!
                          .map((item) => InkWell(
                                onTap: () async {
                                  switch (item.check) {
                                    case 1:
                                      Get.toNamed(
                                          '/product/banner/${item.menu}',
                                          arguments: item.name);
                                      break;
                                    case 2:
                                      Get.toNamed('/product/by/tag/${item.tag}',
                                          arguments: item.name);
                                      break;
                                    case 3:
                                      await launchUrl(
                                        Uri.parse(item.product.toString()),
                                        mode: LaunchMode.inAppWebView,

                                        // webViewConfiguration: const WebViewConfiguration(
                                        //     headers: <String, String>{
                                        //       'my_header_key': 'my_header_value'
                                        //     }),
                                      );
                                      break;
                                  }
                                },
                                child: Container(
                                  //margin: EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                      child: NetworkCatchImage(
                                          imagekey: item.image,
                                          image: Server.secondurl +
                                              '/' +
                                              item.src.toString(),
                                          height: widget.height)),
                                ),
                              ))
                          .toList()),
                  Positioned(
                    //top: 5,
                    child: Padding(
                      padding: EdgeInsets.only(top: widget.height - 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: controller.banner.mainbanner!
                            .asMap()
                            .entries
                            .map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                              width: _current == entry.key ? 25 : 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(50),
                                  color: (Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              255, 54, 41, 233))
                                      .withOpacity(
                                          _current == entry.key ? 0.9 : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ));
      },
    );
  }
}
