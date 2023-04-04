import 'package:dokanpat/configs/themes/app_colors.dart';
import 'package:dokanpat/controllers/categoryController.dart';
import 'package:dokanpat/controllers/product_controller.dart';
import 'package:dokanpat/controllers/product_filter_controller.dart';
import 'package:dokanpat/model/category_model.dart';
import 'package:dokanpat/screens/checkout/shipping_page.dart';
import 'package:dokanpat/screens/pages/about.dart';
import 'package:dokanpat/screens/products/sub_product/horizontal_3_product.dart';
import 'package:dokanpat/screens/products/sub_product/main_product_widget.dart';
import 'package:dokanpat/widgets/empty_page.dart';
import 'package:dokanpat/widgets/images/network_images.dart';
import 'package:dokanpat/widgets/progress/shimmer_prograss.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/demodata/product.dart';
import '../../configs/server.dart';
import '../../configs/themes/custome_text_style.dart';
import '../../controllers/cartController.dart';
import '../../widgets/appbar/titleappbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Option category = Get.arguments as Option;
  final ScrollController _scrollController = ScrollController();
  String sortby = 'popularity';
  int cid = 0;
  int pid = 0;

  @override
  void initState() {
    _scrollController.addListener(scrollevent);
    super.initState();
    setState(() {
      cid = int.parse(Get.parameters['id'].toString());
      pid = int.parse(Get.parameters['pid'].toString());
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollevent);
    super.dispose();
  }

  void scrollevent() {
    CategoryController productcontroller = Get.find();

    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        productcontroller.categoryprogress == false) {
      if (sortby == 'price1') {
        productcontroller.getcategoryProduct(cid, pid, 'price1',
            sortOrder: 'asc');
      } else {
        productcontroller.getcategoryProduct(cid, pid, sortby);
      }
      //print('seccess');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(category.name.toString()),
        centerTitle: true,
        actions: <Widget>[
          Container(
            width: 45,
            child: GetBuilder<CartController>(builder: (cartcontroller) {
              return InkWell(
                onTap: () {
                  Get.toNamed('shopping/cart');
                },
                child: Stack(
                  children: [
                    Positioned(
                        top: -2,
                        left: 5,
                        child: Container(
                            height: 20,
                            width: 40,
                            // decoration: BoxDecoration(
                            //     color: Color.fromARGB(77, 228, 143, 143)),
                            child: Text(
                              cartcontroller.cartlist.length.toString(),
                              style: headerText4.copyWith(
                                  fontSize: 14, color: Colors.red),
                            ))),
                    const Center(
                      child: FaIcon(
                        FontAwesomeIcons.cartShopping,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          PopupMenuButton(
            iconSize: 25,
            onSelected: (String value) {
              CategoryController productcontroller = Get.find();
              if (value == 'price1') {
                productcontroller.getcategoryProduct(cid, pid, 'price1',
                    sortOrder: 'asc');
              } else {
                productcontroller.getcategoryProduct(cid, pid, value);
              }

              setState(() {
                sortby = value;
              });
            },
            padding: EdgeInsets.zero,
            // initialValue: choices[_selection],
            itemBuilder: (BuildContext context) {
              return choices.map((choice) {
                return PopupMenuItem(
                  value: choice['value'].toString(),
                  child: Text(
                    choice['name'],
                    style: TextStyle(
                        color: sortby == choice['value']
                            ? Colors.red
                            : Colors.black),
                  ),
                );
              }).toList();
            },
          )
        ],
      ),
      body: GetBuilder<CategoryController>(builder: (scontroller) {
        return Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                child: Column(
                  children: [
                    Visibility(
                      visible: category.sub!.length > 0,
                      child: const SizedBox(
                        height: 35,
                      ),
                    ),
                    Container(
                      child: scontroller.categoryprogress &&
                              scontroller.categoryProduct.isEmpty
                          ? SizedBox(
                              height: 330 * 2,
                              child: ShimmerProgress(
                                item: 4,
                              ),
                            )
                          : scontroller.categoryProduct.isEmpty
                              ? SizedBox(
                                  height: 330 * 2,
                                  child: EmptyPage(
                                    title: 'No Product !!',
                                  ))
                              : SizedBox(
                                  height: scontroller
                                          .categoryProduct.length.isEven
                                      ? 330.0 /
                                          2 *
                                          scontroller.categoryProduct.length
                                      : 330.0 /
                                          2 *
                                          (scontroller.categoryProduct.length +
                                              1),
                                  child: MainProductWidget(
                                    data: scontroller.categoryProduct,
                                  )),
                    ),
                    SizedBox(
                      height:
                          scontroller.categoryProduct.length <= 3 ? 400 : 10,
                    ),
                    // Positioned(
                    //     top: 0,
                    //     child: ),
                    Visibility(
                      visible: scontroller.categoryprogress,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Theme.of(context).focusColor,
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Visibility(
                  visible: category.sub!.length > 0,
                  child: Container(
                    color: Color.fromARGB(255, 255, 253, 253),
                    height: 35,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: category.sub!.length,
                        itemBuilder: (_, index) {
                          var item = category.sub![index];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                cid = item.child!;
                              });
                              scontroller.subproduct(item.child!);
                            },
                            child: Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                item.name.toString(),
                                style: detailText16.copyWith(
                                    color: cid == item.child
                                        ? Colors.red
                                        : Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            )),
                          );
                        }),
                  )),
            )
          ],
        );
      }),
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
