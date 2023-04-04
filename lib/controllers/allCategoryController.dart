import 'package:dokanpat/configs/api_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../model/category_model.dart';
import '../services/api_services.dart';

class allCategoryController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();

  // var test = "".obs;

  var color = Colors.transparent.obs;
  RxBool catprogress = false.obs;

  var _categoypeoductslist = <categoryModel>[].obs;
  RxList<categoryModel> get categoypeoductslist => _categoypeoductslist;

  int index = 0;

  @override
  void onReady() {
    getcategory();
    super.onReady();
  }

  void getcategory() async {
    catprogress.value = true;
    update();
    var category = await ApiService().getapilistdata(url: apiUrl.category);
    if (category.data != null) {
      List<categoryModel> items = (category.data as List)
          .map((data) => categoryModel.fromJson(data))
          .toList();
      _categoypeoductslist.value = items;
    } else {
      print('====================No Data from category api section===========');
    }

    catprogress.value = false;

    update();
  }
}
