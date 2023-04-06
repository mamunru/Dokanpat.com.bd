import 'dart:math';

import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/product_controller.dart';
import 'package:dokanpat/controllers/product_filter_controller.dart';
import 'package:dokanpat/model/product_model.dart';
import 'package:dokanpat/widgets/images/network_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:facebook_app_events/facebook_app_events.dart';

class MainProductWidget extends StatelessWidget {
  List<productModel> data;
  bool progress;
  MainProductWidget({required this.data, this.progress = false, Key? key})
      : super(key: key);
  static final facebookAppEvents = FacebookAppEvents();

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    //var random = Random().nextInt(data.length);
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: MediaQuery.of(context).size.width / (2 * 330),
              //mainAxisExtent: 256,
            ),
            itemCount: data.length,
            physics: const NeverScrollableScrollPhysics(),
            // scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, index) {
              var single = data[index];
              bool price = single.price.toString().length > 0 ? true : false;
              bool regular =
                  single.regularPrice.toString().length > 0 ? true : false;
              bool image = single.images!.length > 0 ? true : false;

              return price && regular && image
                  ? InkWell(
                      onTap: () {
                        Get.delete<ProductFilterController>();
                        // int catid = single.categories!.length > 0
                        //     ? Random().nextInt(single.categories!.length)
                        //     : 0;
                        Get.toNamed(
                            '/product_details/${single.id}/${single.categories![0].id}',
                            arguments: single);
                        facebookAppEvents.logEvent(
                          name: 'Product_View',
                          parameters: {
                            'product_name': single.name,
                          },
                        );
                      },
                      child: Card(
                        //padding: const EdgeInsets.all(3.0),
                        child: Container(
                          //height: 300,
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                padding: const EdgeInsets.all(2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    NetworkCatchImage(
                                        imagekey: single.images![0].name,
                                        image: single.images![0].src == null
                                            ? 'https://st3.depositphotos.com/23594922/31822/v/1600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg'
                                            : single.images![0].src.toString(),
                                        height: 200),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 5, bottom: 2),
                                      child: Text(
                                        single.name.toString(),
                                        maxLines:
                                            single.name.toString().length < 15
                                                ? 1
                                                : 2,
                                        style: titleText,
                                      ),
                                    ),
                                    Container(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'TK ${double.parse(single.price.toString()).toStringAsFixed(2)}',
                                          style: priceText,
                                        )),
                                    Container(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          'TK ' +
                                              double.parse(single.regularPrice
                                                      .toString())
                                                  .toStringAsFixed(2)
                                                  .toString(),
                                          style: verysmallText.copyWith(
                                              decoration: double.parse(single
                                                          .price
                                                          .toString()) <
                                                      double.parse(single
                                                          .regularPrice
                                                          .toString())
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none),
                                        )),
                                    // Container(
                                    //     padding: const EdgeInsets.only(left: 2),
                                    //     child: Text(
                                    //       'TK ' +
                                    //           double.parse(single['regular_price'])
                                    //               .toStringAsFixed(2)
                                    //               .toString(),
                                    //       style: verysmallText.copyWith(
                                    //           decoration: TextDecoration.lineThrough),
                                    //     )),
                                    Container(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: single.stockStatus == 'instock'
                                            ? Text(
                                                'In Stock',
                                                style: verysmallText.copyWith(
                                                    color: Colors.blue),
                                              )
                                            : Text(
                                                'Out Stock',
                                                style: verysmallText.copyWith(
                                                    color: Colors.red),
                                              )),

                                    Visibility(
                                      visible: double.parse(
                                              single.averageRating.toString()) >
                                          0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: RatingBarIndicator(
                                          rating: double.parse(
                                              single.averageRating.toString()),
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 15.0,
                                          direction: Axis.horizontal,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: 2,
                                  left: 2,
                                  child: Visibility(
                                    visible:
                                        double.parse(single.price.toString()) <
                                            double.parse(
                                                single.regularPrice.toString()),
                                    child: Container(
                                      width: 45,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).focusColor,
                                          borderRadius: const BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(15))),
                                      child: Center(
                                          child: Text(
                                              '${((double.parse(single.price.toString()) - double.parse(single.regularPrice.toString())) * 100 / double.parse(single.regularPrice.toString())).toStringAsFixed(0)}%',
                                              style: detailText.copyWith(
                                                  color: Colors.white))),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Visibility(
                      visible: false,
                      child: Container(),
                    );
            }),
      ),
    );
  }
}
