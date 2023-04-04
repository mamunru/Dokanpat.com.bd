import 'dart:convert';
import 'dart:math';

import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/model/product_model.dart';
import 'package:dokanpat/widgets/images/network_images.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../controllers/product_filter_controller.dart';
import '../../../widgets/single_product_card.dart';
import 'package:get/get.dart';

class Horizontal3ProductList extends StatelessWidget {
  List<productModel> data;
  Horizontal3ProductList({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          var single = data[index];
          bool price = single.price.toString().length > 0 ? true : false;
          bool regular =
              single.regularPrice.toString().length > 0 ? true : false;
          bool image = single.images!.length > 0 ? true : false;
          return price && regular && image
              ? SingleProductCard(
                  ontap: () {
                    // int catid = single.categories!.length > 0
                    //     ? Random().nextInt(single.categories!.length)
                    //     : 0;
                    Get.toNamed(
                        '/product_details/${single.id}/${single.categories![0].id}',
                        arguments: single);
                  },
                  single: single,
                  width: MediaQuery.of(context).size.width / 3)
              : Container();

          // return Card(
          //   child: Stack(
          //     children: [
          //       Container(
          //         width: MediaQuery.of(context).size.width / 3,
          //         padding: const EdgeInsets.all(2),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             ClipRRect(
          //               borderRadius: BorderRadius.circular(8.0),
          //               child: NetworkCatchImage(
          //                   imagekey: single.images![0].name,
          //                   image: single.images![0].src == null
          //                       ? 'https://st3.depositphotos.com/23594922/31822/v/1600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg'
          //                       : single.images![0].src.toString(),
          //                   height: 110),
          //             ),
          //             Container(
          //               height: 40,
          //               padding: const EdgeInsets.only(left: 2, top: 3),
          //               child: Text(
          //                 single.name.toString(),
          //                 maxLines: single.name.toString().length < 15 ? 1 : 2,
          //                 style: titleText,
          //               ),
          //             ),
          //             Container(
          //                 padding: const EdgeInsets.only(left: 2),
          //                 child: Text(
          //                   'TK ${double.parse(single.price.toString()).toStringAsFixed(2)}',
          //                   style: priceText,
          //                 )),
          //             Container(
          //                 padding: const EdgeInsets.only(left: 2),
          //                 child: Text(
          //                   'TK ${double.parse(single.regularPrice.toString()).toStringAsFixed(2)}',
          //                   style: verysmallText.copyWith(
          //                       decoration: TextDecoration.lineThrough),
          //                 )),
          //             Container(
          //                 padding: const EdgeInsets.only(left: 2),
          //                 child: single.stockStatus == 'instock'
          //                     ? Text(
          //                         'In Stock',
          //                         style: verysmallText.copyWith(
          //                             color: Colors.blue),
          //                       )
          //                     : Text(
          //                         'Out Stock',
          //                         style:
          //                             verysmallText.copyWith(color: Colors.red),
          //                       )),
          //             const SizedBox(
          //               height: 5,
          //             )
          //           ],
          //         ),
          //       ),
          //       Positioned(
          //           top: 2,
          //           left: 2,
          //           child: Container(
          //             width: 45,
          //             height: 30,
          //             decoration: BoxDecoration(
          //                 color: Theme.of(context).focusColor,
          //                 borderRadius: const BorderRadius.only(
          //                     bottomRight: Radius.circular(15))),
          //             child: Center(
          //                 child: Text(
          //                     '${((double.parse(single.price.toString()) - double.parse(single.regularPrice.toString()) * 100 / double.parse(single.regularPrice.toString()))).toStringAsFixed(0)}%',
          //                     style: detailText.copyWith(color: Colors.white))),
          //           )),
          //     ],
          //   ),
          // );
        });
  }
}
