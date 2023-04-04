import 'dart:convert';

import 'package:dokanpat/configs/key_value.dart';
import 'package:dokanpat/model/product_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../configs/themes/custome_text_style.dart';
import '../model/shoppingAddress_model.dart';

class WishListController extends GetxController {
  final _box = GetStorage();
  var _wishlistproduct = <productModel>[].obs;

  RxList<productModel> get wishlistproduct => _wishlistproduct;

  bool onloading = false;

  // @override
  // void onInit() {
  //   //storewishlistproduct();
  //   super.onInit();
  // }

  @override
  void onReady() {
    storewishlistproduct();
    super.onReady();
  }

  void storewishlistproduct() {
    print('-------------come from wishlist--------');
    onloading = true;
    update();

    var data = _box.read(ConstKey.sqlwishlistproduct);
    // print(jsonEncode(_box.read(ConstKey.sqlwishlistproduct)));

    if (data != null) {
      List<productModel> finaldata =
          (data as List).map((e) => productModel.fromJson(e)).toList();
      //print(data);
      _wishlistproduct.value = finaldata;

      update();
    }

    onloading = false;

    update();
  }

  void adddata({required productModel product}) {
    int index = _wishlistproduct.value
        .indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      _wishlistproduct.value.remove(product);
      _box.remove(ConstKey.sqlwishlistproduct);
      _box.write(ConstKey.sqlwishlistproduct, _wishlistproduct.value);
      Get.defaultDialog(
          title: "Wishlist !!",
          middleText: "Product is Remove From Your Wishlist. "
              "Please Check Your Wishlist",
          backgroundColor: Color.fromARGB(255, 255, 23, 23),
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white),
          radius: 30,
          actions: [
            Container(
              child: TextButton(
                onPressed: () {
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
    } else {
      _wishlistproduct.add(product);
      update();

      // _box.remove(ConstKey.wishlist);
      _box.write(ConstKey.sqlwishlistproduct, _wishlistproduct.value);
      // print(jsonEncode(_box.read(ConstKey.wishlist)));
      Get.defaultDialog(
          title: "Wishlist",
          middleText: "Product is add in Your Wishlist. "
              "Please Check Your Wishlist",
          backgroundColor: Color.fromARGB(255, 23, 228, 255),
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white),
          radius: 30,
          actions: [
            Container(
              child: TextButton(
                onPressed: () {
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
    update();
  }

  void deleteMethod(productModel product) {
    _wishlistproduct.remove(product);
    _box.remove(ConstKey.sqlwishlistproduct);
    _box.write(ConstKey.sqlwishlistproduct, _wishlistproduct);
    update();
  }
}
