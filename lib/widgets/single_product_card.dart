import 'package:dokanpat/model/product_model.dart';
import 'package:flutter/material.dart';

import '../configs/themes/custome_text_style.dart';
import 'images/network_images.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SingleProductCard extends StatelessWidget {
  productModel single;
  double width;
  VoidCallback? ontap;
  SingleProductCard(
      {this.ontap, required this.single, required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          InkWell(
            onTap: ontap,
            child: Container(
              width: width,
              //padding: const EdgeInsets.all(2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                    ),
                    child: NetworkCatchImage(
                        imagekey: single.images![0].name,
                        image: single.images![0].src == null
                            ? 'https://st3.depositphotos.com/23594922/31822/v/1600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg'
                            : single.images![0].src.toString(),
                        height: 110),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 2, top: 3),
                    child: Text(
                      single.name.toString(),
                      style: titleText,
                      maxLines: single.name.toString().length < 15 ? 1 : 2,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 3),
                      child: Text(
                        'TK ' +
                            double.parse(single.price.toString())
                                .toStringAsFixed(2)
                                .toString(),
                        style: priceText,
                      )),
                  Container(
                      padding: const EdgeInsets.only(left: 3),
                      child: Text(
                        // ignore: prefer_interpolation_to_compose_strings
                        'TK ' +
                            double.parse(single.regularPrice.toString())
                                .toStringAsFixed(2)
                                .toString(),
                        style: verysmallText.copyWith(
                            decoration: double.parse(single.price.toString()) <
                                    double.parse(single.regularPrice.toString())
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      )),
                  Container(
                      padding: const EdgeInsets.only(left: 3, bottom: 2),
                      child: single.stockStatus == 'instock'
                          ? Text(
                              'In Stock',
                              style: verysmallText.copyWith(color: Colors.blue),
                            )
                          : Text(
                              'Out Stock',
                              style: verysmallText.copyWith(color: Colors.red),
                            )),
                  Visibility(
                    visible: double.parse(single.averageRating.toString()) > 0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: RatingBarIndicator(
                        rating: double.parse(single.averageRating.toString()),
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
          ),

          // Container(
          //   width: MediaQuery.of(context).size.width/3.8,
          //   child: Padding(
          //     padding: const EdgeInsets.all(3.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         NetworkCatchImage(imagekey: single['images'][0]['src'],
          //         image: single['images'][0]['src'], height: 110),
          //         Padding(
          //           padding: EdgeInsets.all(5.0),
          //           child:
          //           Expanded(
          //             flex: 1,
          //             //fit: FlexFit.tight,
          //             child: SizedBox(
          //               height: 30,
          //               child: Text(
          //                 single['name'],
          //                 style: titleText,
          //                 ),
          //             )
          //               ),
          //         ),
          //         Padding(
          //           padding:const EdgeInsets.only(left: 5.0),
          //           child: Flexible(child: Text('TK '+ double.parse(single['price']).toStringAsFixed(2).toString(),style: priceText,))),

          //          Padding(
          //                 padding: EdgeInsets.only(left: 5.0),
          //                 child: Expanded(
          //                     child: Text(
          //                   // ignore: prefer_interpolation_to_compose_strings
          //                   'TK ' +
          //                       double.parse(single['regular_price'])
          //                           .toStringAsFixed(2)
          //                           .toString(),
          //                   style: verysmallText.copyWith(
          //                       decoration: TextDecoration.lineThrough),
          //                 ))),
          //       Padding(
          //                 padding: EdgeInsets.only(left: 5.0,bottom: 3),
          //                 child: Expanded(
          //                     child: single['stock_status']=='instock' ?Text(
          //                   'In Stock',
          //                   style: verysmallText.copyWith(color: Colors.blue),
          //                 ): Text('Out Stock',style: verysmallText.copyWith(color: Colors.red),)
          //                 )
          //                 ),
          //       ],
          //     ),
          //   ),
          // ),

          Positioned(
              top: 0,
              left: 0,
              child: Visibility(
                visible: double.parse(single.price.toString()) <
                        double.parse(single.regularPrice.toString())
                    ? true
                    : false,
                child: Container(
                  width: 45,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Theme.of(context).focusColor,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(15))),
                  child: Center(
                      child: Text(
                          ((double.parse(single.price.toString()) -
                                          double.parse(
                                              single.regularPrice.toString())) *
                                      100 /
                                      double.parse(
                                          single.regularPrice.toString()))
                                  .toStringAsFixed(0)
                                  .toString() +
                              '%',
                          style: detailText.copyWith(color: Colors.white))),
                ),
              )),
        ],
      ),
    );
  }
}
