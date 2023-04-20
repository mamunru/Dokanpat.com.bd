import 'package:dokanpat/controllers/product_controller.dart';
import 'package:dokanpat/screens/products/sub_product/main_product_widget.dart';
import 'package:dokanpat/widgets/empty_page.dart';
import 'package:dokanpat/widgets/progress/shimmer_prograss.dart';
import 'package:flutter/material.dart';

import '../../configs/demodata/product.dart';
import '../../widgets/appbar/product_appbar.dart';
import '../../widgets/appbar/searchpage_appbar.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ScrollController _scrollController = ScrollController();
  //TokenController tokenController = Get.find();
  ProductController productcontroller = Get.find();
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
    ProductController productcontroller = Get.find();
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        _scrollController.offset >= MediaQuery.of(context).size.height / 2) {
      print(productcontroller.oldsearch);
      if (sortby == 'price1') {
        productcontroller.searchProduct(productcontroller.oldsearch,
            sortBy: 'price1', sortOrder: 'asc');
      } else {
        productcontroller.searchProduct(productcontroller.oldsearch,
            sortBy: sortby);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: SearchBar(),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            iconSize: 25,
            onSelected: (String value) {
              ProductController productcontroller = Get.find();
              if (value == 'price1') {
                productcontroller.searchProduct(productcontroller.oldsearch,
                    sortBy: 'price1', sortOrder: 'asc');
              } else {
                productcontroller.searchProduct(productcontroller.oldsearch,
                    sortBy: value);
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
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          child: Column(
            children: [
              GetBuilder<ProductController>(builder: (controller) {
                return controller.searchprogress.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ShimmerProgress(
                          item: 4,
                        ),
                      )
                    : controller.searchproducts.isEmpty &&
                            controller.onsearchloading == false
                        ? EmptyPage(
                            title: 'Empty Search. Please Search Your Products',
                          )
                        : SizedBox(
                            // height:
                            //     330 * controller.searchproducts.length / 2 + 50,
                            height: controller.searchproducts.length.isEven
                                ? 330.0 / 2 * controller.searchproducts.length
                                : 330.0 /
                                    2 *
                                    (controller.searchproducts.length + 1),
                            child: MainProductWidget(
                                data: controller.searchproducts));
              }),
              // CustomScrollView(
              //   controller: _scrollController,
              //   slivers: [
              //     SliverToBoxAdapter(
              //       child:
              //       ,
              //     ),
              //     SliverVisibility(
              //         visible: true,
              //         sliver: Container(
              //           child: CircularProgressIndicator(Theme.of(context).focusColor,),
              //         ))
              //   ],
              // ),
              GetBuilder<ProductController>(builder: (pc) {
                return Visibility(
                  visible: pc.onsearchloading,
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).focusColor,
                        ),
                      )),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
