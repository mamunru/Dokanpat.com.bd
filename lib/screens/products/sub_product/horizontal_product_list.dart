import 'dart:convert';
import 'dart:math';

import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/model/product_model.dart';
import 'package:dokanpat/widgets/images/network_images.dart';
import 'package:dokanpat/widgets/single_product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HorizontalProductList extends StatelessWidget {
  List<productModel> data;
  HorizontalProductList({required this.data, Key? key}) : super(key: key);

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
          // int catid = single.categories!.length > 0
          //     ? Random().nextInt(single.categories!.length)
          //     : 0;
          return price && regular && image
              ? SingleProductCard(
                  ontap: () {
                    Get.toNamed(
                        '/product_details/${single.id}/${single.categories![0].id}',
                        arguments: single);
                  },
                  single: single,
                  width: MediaQuery.of(context).size.width / 3.4)
              : Container();
        });
  }
}
