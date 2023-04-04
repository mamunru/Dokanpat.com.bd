import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dokanpat/configs/api_url.dart';
import 'package:dokanpat/configs/key_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../configs/server.dart';
import '../model/category_model.dart';
import '../model/onscreensms_model.dart';
import '../services/api_services.dart';
import '../widgets/images/network_images.dart';
import '../widgets/onscreendailog.dart';
import 'package:get_storage/get_storage.dart';

class MyDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();

  // var test = "".obs;

  var color = Colors.transparent.obs;
  RxBool catprogress = false.obs;
  final _box = GetStorage();

  var _categoypeoductslist = <categoryModel>[].obs;
  RxList<categoryModel> get categoypeoductslist => _categoypeoductslist;
  var _onscreen = <onscreensmsModel>[].obs;
  RxList<onscreensmsModel> get onscreen => _onscreen;

  int index = 1000;
  int subindex = 1000;
  bool state = false;
  bool substate = false;
  int day = 0;

  var data = ''.obs;

  @override
  void onInit() {
    DateTime now = new DateTime.now();
    int _day = int.parse(_box.read(ConstKey.today).toString() == 'null'
        ? '0'
        : _box.read(ConstKey.today).toString());

    if (now.day != _day) {
      getcategory();
    } else {
      storedatafunction();
    }

    onscreensms();

    // ontest();
    super.onInit();
  }

  void ontest() async {
    String finalurl = '${Server.secondapi}${apiUrl.category}';
    print(finalurl);
    try {
      var response = await Dio()
          .get(finalurl, options: Options(contentType: 'application/json'));

      data.value = jsonDecode(response.data);
    } catch (e) {
      data.value = e.toString();
    }
    update();
  }

  void storedatafunction() {
    var _childcategory = _box.read(ConstKey.chidCategory);
    List<categoryModel> childcategory =
        (_childcategory as List).map((e) => categoryModel.fromJson(e)).toList();
    _categoypeoductslist.value = childcategory;
  }

  // void toggleDrawer() {
  //   if (categoypeoductslist.isEmpty) {
  //     getcategory();
  //   }
  //   zoomDrawerController.toggle?.call();

  //   update();
  // }

  // void scrollController(double v) {
  //   if (v <= 30) {
  //     color.value = Colors.transparent;
  //   } else {
  //     color.value = Colors.white;
  //   }

  //   // print(test.toString());

  //   update();
  // }

  void getcategory() async {
    catprogress.value = true;
    update();
    var category = await ApiService().getapilistdata(url: apiUrl.category);
    if (category.data != null) {
      List<categoryModel> items = (category.data as List)
          .map((data) => categoryModel.fromJson(data))
          .toList();
      _categoypeoductslist.value = items;
      _box.write(ConstKey.chidCategory, _categoypeoductslist);
    } else {
      print('====================No Data from category api section===========');
    }

    catprogress.value = false;

    update();
  }

  void Dropdown(int i) {
    if (i == index) {
      state = state == true ? false : true;
    } else {
      state = true;
    }
    substate = false;
    index = i;

    update();
  }

  void Subindexupdate(bool status, int i, int main) {
    if (status) {
      _categoypeoductslist.value[main].option![i].show = 0;
    } else {
      _categoypeoductslist.value[main].option![i].show = 1;
    }
    update();
  }

  void onscreensms() async {
    DateTime now = new DateTime.now();
    int _day = int.parse(_box.read(ConstKey.today).toString() == 'null'
        ? '0'
        : _box.read(ConstKey.today).toString());
    bool isFirstLaunch = _box.read(ConstKey.isFirstLaunch) ?? true;

    if (now.day != _day && isFirstLaunch == false) {
      _box.write(ConstKey.today, now.day.toString());
      var data = await ApiService().onscreensms();
      onscreen.value = data;

      //Get.toNamed('/onscreen');
      // Get.dialog(Dialog(
      //   child: OnscreenDailog(),
      // ));
      if (data.length > 0) {
        Get.defaultDialog(
            backgroundColor: Colors.transparent,
            title: '',
            middleText: '',
            buttonColor: Colors.red,
            onConfirm: () {
              Get.back();
            },
            actions: [
              Builder(builder: (context) {
                return Container(
                  child: Column(
                    children: [
                      Container(
                        height: data.length <= 2
                            ? 300 * double.parse(data.length.toString())
                            : MediaQuery.of(context).size.height - 230,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: ListView.builder(
                            itemCount: data.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, i) {
                              return Visibility(
                                visible: data[i].image.toString().length > 10
                                    ? true
                                    : false,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: NetworkCatchImage(
                                      imagekey: data[i].image.toString(),
                                      image: data[i].image.toString(),
                                      height: 280,
                                      width: MediaQuery.of(context).size.width *
                                          .70,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                );
              })
            ]);
      }
    }

    update();
  }
}
