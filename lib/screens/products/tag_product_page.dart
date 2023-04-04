import 'package:dokanpat/controllers/tagController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/demodata/product.dart';
import '../../configs/themes/custome_text_style.dart';
import '../../controllers/cartController.dart';
import '../../widgets/appbar/titleappbar.dart';
import 'sub_product/main_product_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TagProductPage extends StatefulWidget {
  const TagProductPage({super.key});

  @override
  State<TagProductPage> createState() => _TagProductPageState();
}

class _TagProductPageState extends State<TagProductPage> {
  var title = Get.arguments;
  final ScrollController _scrollController = ScrollController();
  String sortby = 'popularity';

  @override
  void initState() {
    _scrollController.addListener(scrollevent);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollevent);
    super.dispose();
  }

  void scrollevent() {
    TagController productcontroller = Get.find();
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        productcontroller.categoryProduct.length >= 20) {
      if (sortby == 'price1') {
        productcontroller.getcategoryProduct('price1', sortOrder: 'asc');
      } else {
        productcontroller.getcategoryProduct(sortby, sortOrder: 'desc');
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
              TagController productcontroller = Get.find();
              if (value == 'price1') {
                productcontroller.getcategoryProduct('price1',
                    sortOrder: 'asc');
              } else {
                productcontroller.getcategoryProduct(value);
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
      body: GetBuilder<TagController>(builder: (scontroller) {
        return SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Positioned(
                //     top: 0,
                //     child: Titleappbar(
                //       title: title,
                //     )),
                Container(
                  child: SizedBox(
                      height: scontroller.categoryProduct.length.isEven
                          ? 330.0 / 2 * scontroller.categoryProduct.length
                          : 330.0 /
                              2 *
                              (scontroller.categoryProduct.length + 1),
                      child: MainProductWidget(
                        data: scontroller.categoryProduct,
                      )),
                ),
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
                ),
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
    );
  }
}
