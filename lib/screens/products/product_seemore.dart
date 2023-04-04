import 'package:dokanpat/controllers/product_controller.dart';
import 'package:flutter/material.dart';

import '../../configs/demodata/product.dart';
import '../../configs/themes/custome_text_style.dart';
import '../../controllers/cartController.dart';
import '../../widgets/appbar/product_appbar.dart';
import '../../widgets/appbar/searchpage_appbar.dart';
import 'package:get/get.dart';

import '../../widgets/appbar/titleappbar.dart';
import 'sub_product/main_product_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductSeemore extends StatefulWidget {
  ProductSeemore({super.key});

  @override
  State<ProductSeemore> createState() => _ProductSeemoreState();
}

class _ProductSeemoreState extends State<ProductSeemore> {
  var title = Get.arguments;

  final ScrollController _scrollController = ScrollController();
  String sortby = 'date';

  @override
  void initState() {
    _scrollController.addListener(scrollevent);
    if (title != "Specialty Kitchen Tools") {
      setState(() {
        sortby = 'popularity';
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollevent);
    super.dispose();
  }

  void scrollevent() {
    ProductController productcontroller = Get.find();
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (title == "Specialty Kitchen Tools") {
        if (productcontroller.newarrivallast == false) {
          if (sortby == 'price1') {
            // productcontroller.getcategoryProduct('price1',
            //     sortOrder: 'asc');
            productcontroller.filternewarival(
                sortBy: 'price1', sortOrder: 'asc');
          } else {
            productcontroller.filternewarival(sortBy: sortby);
          }
        }
      } else {
        if (productcontroller.dailylast == false) {
          if (sortby == 'price1') {
            productcontroller.filterdailyproduct(
                sortBy: 'price1', sortOrder: 'asc');
          } else {
            productcontroller.filterdailyproduct(sortBy: sortby);
          }
        }
      }

      print('seccess');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(title.toString()),
        centerTitle: true,
        actions: <Widget>[
          Container(
            width: 40,
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
              setState(() {
                sortby = value;
              });
              ProductController productcontroller = Get.find();
              if (title == "Specialty Kitchen Tools") {
                if (value == 'price1') {
                  // productcontroller.getcategoryProduct('price1',
                  //     sortOrder: 'asc');
                  productcontroller.filternewarival(
                      sortBy: 'price1', sortOrder: 'asc');
                } else {
                  productcontroller.filternewarival(sortBy: sortby);
                }
              } else {
                if (value == 'price1') {
                  productcontroller.filterdailyproduct(
                      sortBy: 'price1', sortOrder: 'asc');
                } else {
                  productcontroller.filterdailyproduct(sortBy: sortby);
                }
              }
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
      body: GetBuilder<ProductController>(builder: (controller) {
        var data = title == "Specialty Kitchen Tools"
            ? controller.newproducts
            : controller.dailyproducts;

        bool pg = title == "Specialty Kitchen Tools"
            ? controller.nwprogress.value
            : controller.dyprogress.value;

        return SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                    height: data.length.isEven
                        ? 330.0 / 2 * data.length
                        : 330.0 / 2 * (data.length + 1),
                    child: MainProductWidget(
                      data: data,
                    )),
                Visibility(
                  visible: controller.loading,
                  child: Container(
                    // padding: const EdgeInsets.symmetric(vertical: 15),
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
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).focusColor,
        onPressed: () {
          Get.back();
        },
        child: const FaIcon(FontAwesomeIcons.angleLeft),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
