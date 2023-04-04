import 'dart:convert';

import 'package:dokanpat/configs/key_value.dart';
import 'package:dokanpat/configs/woocommerce_api.dart';
import 'package:dokanpat/model/order_model.dart';
import 'package:dokanpat/model/review_model.dart';
import 'package:dokanpat/services/woo_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../configs/themes/custome_text_style.dart';

class OrderHistoryContriller extends GetxController {
  final _box = GetStorage();
  bool onloading = false;
  bool onupdate = false;
  bool oncheck = false;
  bool reviewloading = false;

  int pageindex = 1;

  var _orderhistory = <OrderModel>[].obs;
  RxList<OrderModel> get orderhistory => _orderhistory;

  var _review = <reviewModel>[].obs;
  RxList<reviewModel> get review => _review;

  // @override
  // void onReadoy() {

  //   //onreviewloading();
  //   super.onReady();
  // }

  @override
  void onInit() {
    getmyorder();
    super.onInit();
  }

  void getmyorder() async {
    onloading = true;
    update();
    String userid = await _box.read(ConstKey.userid);
    var data = await WooServices().OrderHistory(userid, page: 1);
    _orderhistory.value = data;

    if (data.length > 0) {
      String email = _box.read(ConstKey.fixemail);
      var reviewapi = await WooServices().getreview(email: email);
      review.value = reviewapi;
      print(reviewapi.length);

      if (reviewapi.isNotEmpty) {
        for (var i = 0; i < data.length; i++) {
          data[i].lineItems!.forEach((e) {
            reviewapi.forEach(
              (r) {
                if (r.productId == e.productId) {
                  _orderhistory.value[i].totalTax = r.rating.toString();
                  // print(jsonDecode(_orderhistory[i].toString()));
                }
              },
            );

            // if (index >= 0) {
            //   element.totalTax = review[index].rating.toString();
            // }

            // print(review[index].rating.toString());
          });
        }
        ;
      }
    }

    onloading = false;

    pageindex = 2;

    update();
  }

  void getmyorderupdate() async {
    onupdate = true;
    update();
    String userid = await _box.read(ConstKey.userid);
    if (_orderhistory.value.length >= 20) {
      var data = await WooServices().OrderHistory(userid, page: pageindex);
      _orderhistory.addAll(data);

      pageindex += 1;
    }

    onupdate = false;
    update();
  }

  void setreview(
      {required int id, required String rating, String? text}) async {
    reviewloading = true;
    update();
    String name = _box.read(ConstKey.username);
    String email = _box.read(ConstKey.fixemail);

    oncheck = await WooServices().Setreview(
        pid: id,
        review: text.toString(),
        reviewer: name,
        email: email,
        rating: rating);
    getmyorder();
    Get.back();
    if (oncheck) {
      Get.defaultDialog(
          title: "Thank For Your Review",
          middleText: "Your Successfully Create  ",
          backgroundColor: Colors.teal,
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white),
          radius: 30,
          actions: [
            Container(
              child: InkWell(
                onTap: () {
                  Get.back();

                  // Get.offAndToNamed('/login');
                  //Get.off(LoginPage());
                },
                child: Container(
                  height: 30,
                  width: 200,
                  child: Center(
                    child: Text(
                      'OK',
                      style: detailText18.copyWith(color: Colors.red),
                    ),
                  ),
                ),
              ),
            )
          ]);
    } else {
      Get.defaultDialog(
          title: "Sorry !! ",
          middleText: "Your Review Not  Created. Please Try Again   ",
          backgroundColor: Colors.red,
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white),
          radius: 30,
          actions: [
            Container(
              child: InkWell(
                onTap: () {
                  Get.back();

                  // Get.offAndToNamed('/login');
                  //Get.off(LoginPage());
                },
                child: Container(
                  height: 30,
                  width: 200,
                  child: Center(
                    child: Text(
                      'OK',
                      style: detailText18.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ]);
    }

    reviewloading = false;

    update();
  }

  //Review
  void onreviewloading() async {
    String email = _box.read(ConstKey.fixemail);
    print(email);
    var reviewapi = await WooServices().getreview(email: email);
    review.value = reviewapi;
    print(reviewapi.length);
    // if (reviewapi.isNotEmpty) {
    //   for (int i = 0; i < _orderhistory.value.length; i++) {
    //     print(i);
    //     for (var j = 0; j < _orderhistory.value[i].lineItems!.length; j++) {
    //       var product = _orderhistory.value[i].lineItems![j];

    //       int index = reviewapi
    //           .indexWhere((element) => element.productId == product.productId);
    //       _orderhistory.value[i].lineItems![j].subtotalTax ==
    //           reviewapi[index].rating.toString();
    //       print('======' + reviewapi[index].rating.toString());
    //     }
    //     ;
    //   }
    //   ;
    // }
    update();
  }
}
