// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:dokanpat/configs/server.dart';
import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/cartController.dart';
import 'package:dokanpat/controllers/onlineProductController.dart';
import 'package:dokanpat/controllers/product_filter_controller.dart';
import 'package:dokanpat/model/product_model.dart';
import 'package:dokanpat/model/review_model.dart';
import 'package:dokanpat/widgets/appbar/product_appbar.dart';
import 'package:dokanpat/widgets/images/product_image.dart';
import 'package:dokanpat/widgets/slider.dart';
import 'package:dokanpat/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rive/rive.dart';

import '../../../model/productimage_model.dart';
import '../../../widgets/progress/shimmer_prograss.dart';
import '../sub_product/main_product_widget.dart';
import 'viriation_details.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class OnlineProductDetails extends StatefulWidget {
  OnlineProductDetails({super.key});

  @override
  State<OnlineProductDetails> createState() => _OnlineProductDetailsState();
}

class _OnlineProductDetailsState extends State<OnlineProductDetails> {
  //ProductFilterController reviewcontroller = Get.put(ProductFilterController());
  // productModel product =
  //     productModel.fromJson(jsonDecode(Get.parameters['itembyIndex']!));
  ScrollController _scrollController = ScrollController();
  productModel? product;
  bool description = true;
  bool review = true;
  bool info = true;
  bool color = false;
  int vid = 0;

  String variation_value = '';
  String src = '';
  int qty = 1;
  bool tagname = false;
  bool tagstatus = false;
  bool contact = false;
  bool onveriation = false;
  //int vindexid = 0;

  List<ProductImageModel> _productimage = [];

  @override
  void initState() {
    _scrollController.addListener(scrollevent);
    ;
    OnlineProductFilterController pcontroller = Get.find();
    setState(() {
      product = pcontroller.singleproduct!;
    });
    product!.images!.forEach((element) {
      _productimage.add(ProductImageModel(
          name: element.id.toString(), src: element.src.toString()));
    });
    CartController cartcontroll = Get.find();
    // print(cartcontroll.state);
    product!.tags!.forEach((v) {
      if (v.name.toString().toLowerCase() == Server.tagname.toLowerCase()) {
        setState(() {
          tagname = true;
          tagstatus = true;
        });
      }
    });
    if (product!.variationProducts != null) {
      setState(() {
        onveriation = true;
        // vid = 1;
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
    // MyDrawerController themecontroller = Get.find();
    OnlineProductFilterController productcontroller = Get.find();
    // themecontroller.scrollController(_scrollController.offset);
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        productcontroller.mainproduct.length > 2 &&
        productcontroller.progress == false) {
      print('ok');
      productcontroller.updateRandomProduct(product!.categories!);
    }
  }

  //final passToModel = Model.fromJson(decode);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: Key(product!.id.toString()),
      body: GetBuilder<OnlineProductFilterController>(builder: (pcontroller) {
        //productModel product = pcontroller.productinfo!;

        return Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 75,
                      ),
                      SizedBox(
                        height: 500,
                        child: ProductImage(500, imageList: _productimage),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Text(
                                product!.name.toString(),
                                style: headerText,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: double.parse(product!.price.toString()) <
                                double.parse(product!.regularPrice.toString()),
                            child: Container(
                              width: 100,
                              height: 35,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).focusColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  ('Save: ' +
                                          ((double.parse(product!.price
                                                          .toString()) -
                                                      double.parse(product!
                                                          .regularPrice
                                                          .toString())) *
                                                  100 /
                                                  double.parse(product!
                                                      .regularPrice
                                                      .toString()))
                                              .abs()
                                              .toStringAsFixed(0)
                                              .toString()) +
                                      '%',
                                  style: headerText4.copyWith(
                                      color: Colors.white)),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          double.parse(product!.price.toString())
                                  .toStringAsFixed(2)
                                  .toString() +
                              '  TK',
                          style: headerText2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          double.parse(product!.regularPrice.toString())
                                  .toStringAsFixed(2)
                                  .toString() +
                              '  TK',
                          style: headerText4.copyWith(
                              decoration:
                                  double.parse(product!.price.toString()) <
                                          double.parse(
                                              product!.regularPrice.toString())
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text.rich(TextSpan(
                            text: 'Stock ',
                            style: detailText14,
                            children: <InlineSpan>[
                              product!.stockStatus == 'instock'
                                  ? TextSpan(
                                      text: 'In Stock',
                                      style: detailText14.copyWith(
                                          color: Colors.blue),
                                    )
                                  : TextSpan(
                                      text: 'Out Stock',
                                      style: detailText14.copyWith(
                                          color: Colors.red),
                                    )
                            ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text.rich(TextSpan(
                            text: 'SKU ',
                            style: detailText14,
                            children: <InlineSpan>[
                              TextSpan(
                                text: product!.sku,
                                style: detailText14.copyWith(color: Colors.red),
                              )
                            ])),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        // alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Html(data: product!.shortDescription)),
                      ),
                      product!.variationProducts == null
                          ? SizedBox()
                          : Container(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product!.variationProducts![0]
                                        .attributesArr![0].name
                                        .toString()
                                        .replaceAll('pa_', ''),
                                    style: headerText3,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    //height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      spacing: 8.0,
                                      children: product!.variationProducts!
                                          .map((data) {
                                        return InkWell(
                                          onTap: (() {
                                            CartController cartcontroller =
                                                Get.find();
                                            setState(() {
                                              product!.price = data.price;
                                              product!.regularPrice =
                                                  data.regularPrice;
                                              product!.stockStatus =
                                                  data.stockStatus;
                                            });

                                            if (tagname) {
                                              if (cartcontroller.state ==
                                                      'BD-12' ||
                                                  cartcontroller.state ==
                                                      'BD-BD-39') {
                                                print(cartcontroller.state);
                                                showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  builder: (context) =>
                                                      Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.75,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                25.0),
                                                        topRight:
                                                            Radius.circular(
                                                                25.0),
                                                      ),
                                                    ),
                                                    child: VeriationProduct(
                                                      product: product!,
                                                      src: data.featureImage
                                                          .toString(),
                                                      vid: data.id!,
                                                      variation_value: data
                                                          .attributesArr![0]
                                                          .attributeName
                                                          .toString(),
                                                      oncheck: onveriation,
                                                      tagname: tagname,
                                                      tagstatus: tagstatus,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                Get.defaultDialog(
                                                    title: "Sorry !!",
                                                    middleText:
                                                        "Product is not Available In your Location ",
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 255, 23, 23),
                                                    titleStyle: const TextStyle(
                                                        color: Colors.white),
                                                    middleTextStyle:
                                                        const TextStyle(
                                                            color:
                                                                Colors.white),
                                                    radius: 30,
                                                    actions: [
                                                      Container(
                                                        child: TextButton(
                                                          onPressed: () {
                                                            Get.back();

                                                            // Get.offAndToNamed('/login');
                                                            //Get.off(LoginPage());
                                                          },
                                                          child: Center(
                                                            child: Text(
                                                              'OK',
                                                              style: detailText18
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ]);
                                              }
                                            } else {
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (context) => Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.75,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(25.0),
                                                      topRight:
                                                          Radius.circular(25.0),
                                                    ),
                                                  ),
                                                  child: VeriationProduct(
                                                    product: product!,
                                                    src: data.featureImage
                                                        .toString(),
                                                    vid: data.id!,
                                                    variation_value: data
                                                        .attributesArr![0]
                                                        .attributeName
                                                        .toString(),
                                                    oncheck: onveriation,
                                                    tagname: tagname,
                                                    tagstatus: tagstatus,
                                                  ),
                                                ),
                                              );
                                            }
                                            // Get.bottomSheet(Container(
                                            //   color: Colors.white,
                                            //   height: Get.height * 75,
                                            //   width: MediaQuery.of(context)
                                            //       .size
                                            //       .width,
                                            //   child: VeriationProduct(
                                            //     product: product,
                                            //     src: data.featureImage
                                            //         .toString(),
                                            //     vid: data.id!,
                                            //     variation_value:
                                            //         variation_value,
                                            //   ),
                                            // ));
                                            // _scrollController.animateTo(
                                            //   _scrollController
                                            //       .position.minScrollExtent,
                                            //   duration: Duration(seconds: 2),
                                            //   curve: Curves.fastOutSlowIn,
                                            // );
                                          }),
                                          child: Container(
                                            height: 40,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.5,
                                            margin: const EdgeInsets.only(
                                                right: 5, bottom: 5),
                                            decoration: BoxDecoration(
                                                color: vid !=
                                                        int.parse(
                                                            data.id.toString())
                                                    ? const Color.fromARGB(
                                                        31, 124, 117, 117)
                                                    : Theme.of(context)
                                                        .focusColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              child: Center(
                                                child: Text(
                                                  data.attributesArr![0]
                                                      .attributeName
                                                      .toString(),
                                                  style: detailText15,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                      // Container(
                      //   height: 35,
                      //   //padding: const EdgeInsets.only(bottom: 5),
                      //   child: Row(
                      //     children: [
                      //       const SizedBox(
                      //         width: 5,
                      //       ),
                      //       const Expanded(
                      //         child: Text(
                      //           'Select The Quantity',
                      //           style: detailText15,
                      //         ),
                      //       ),
                      //       Expanded(
                      //           child: Container(
                      //         child: Row(
                      //           children: [
                      //             InkWell(
                      //               onTap: () {
                      //                 setState(() {
                      //                   if (qty > 1) {
                      //                     qty -= 1;
                      //                   }
                      //                 });
                      //               },
                      //               child: Container(
                      //                 height: 28,
                      //                 width: 28,
                      //                 alignment: Alignment.center,
                      //                 decoration: const BoxDecoration(
                      //                   color:
                      //                       Color.fromARGB(76, 233, 169, 169),
                      //                 ),
                      //                 child: const FaIcon(
                      //                   FontAwesomeIcons.minus,
                      //                   color:
                      //                       Color.fromARGB(255, 247, 124, 124),
                      //                   size: 18,
                      //                 ),
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               width: 10,
                      //             ),
                      //             Container(
                      //               width: 100,
                      //               height: 28,
                      //               alignment: Alignment.center,
                      //               decoration: BoxDecoration(
                      //                   color: Colors.white10,
                      //                   border: Border.all(
                      //                       width: 1, color: Colors.black12)),
                      //               child: Text(
                      //                 qty.toString(),
                      //                 style: detailText16.copyWith(
                      //                     fontWeight: FontWeight.w400),
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               width: 10,
                      //             ),
                      //             InkWell(
                      //               onTap: () {
                      //                 setState(() {
                      //                   qty += 1;
                      //                 });
                      //               },
                      //               child: Container(
                      //                 height: 28,
                      //                 width: 28,
                      //                 alignment: Alignment.center,
                      //                 decoration: const BoxDecoration(
                      //                   color:
                      //                       Color.fromARGB(76, 233, 169, 169),
                      //                 ),
                      //                 child: const FaIcon(
                      //                   FontAwesomeIcons.plus,
                      //                   color:
                      //                       Color.fromARGB(255, 247, 124, 124),
                      //                   size: 18,
                      //                 ),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       )),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 2,
                      ),
                      // product!.stockStatus == 'instock'
                      //     ? Container(
                      //         width: MediaQuery.of(context).size.width,
                      //         child: tagname
                      //             ? Container(
                      //                 height: 36,
                      //                 width: MediaQuery.of(context).size.width,
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'This Product Only For Meherpur & Chuadanga',
                      //                     style: detailText16,
                      //                   ),
                      //                 ),
                      //               )
                      //             : Row(
                      //                 children: [],
                      //               ),
                      //       )
                      //     : SizedBox(
                      //         height: 35,
                      //         width: MediaQuery.of(context).size.width,
                      //         child: Center(
                      //           child: Text(
                      //             'Product is not Available !!',
                      //             style:
                      //                 detailText18.copyWith(color: Colors.red),
                      //           ),
                      //         ),
                      //       ),

                      TitleBar(
                        title: 'descriptions',
                        callback: () {
                          print('ok');
                          setState(() {
                            description = description ? false : true;
                          });
                        },
                        up: description,
                      ),
                      Visibility(
                        visible: description,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          // alignment: Alignment.center,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Html(
                                data: product!.description,
                                style: {
                                  "li": Style(fontSize: FontSize.large),
                                  "p": Style(fontSize: FontSize.larger)
                                },
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TitleBar(
                        title: 'Additional Information',
                        callback: () {
                          print('ok');
                          setState(() {
                            info = info ? false : true;
                          });
                        },
                        up: info,
                      ),
                      Visibility(
                          visible: info,
                          child: Container(
                            child: Column(
                              children:
                                  product!.attributes!.asMap().entries.map((e) {
                                Attributes data = e.value;
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: e.key.isOdd
                                          ? const Color.fromARGB(
                                              95, 189, 182, 182)
                                          : Colors.white),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Text(
                                        data.name.toString(),
                                        style: detailText16,
                                      )),
                                      Expanded(
                                          child: Text(
                                        data.options
                                            .toString()
                                            .replaceAll('[', '')
                                            .replaceAll(']', ''),
                                        style: detailText16,
                                      )),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),

                            // child: ListView.builder(
                            //     padding: EdgeInsets.zero,
                            //     itemCount: product!.attributes!.length,
                            //     physics: const NeverScrollableScrollPhysics(),
                            //     itemBuilder: (_, index) {
                            //       Attributes data = product!.attributes![index];
                            //       return Container(
                            //         height: 45,
                            //         margin: const EdgeInsets.symmetric(
                            //             horizontal: 5),
                            //         padding: const EdgeInsets.symmetric(
                            //             horizontal: 5),
                            //         width: MediaQuery.of(context).size.width,
                            //         decoration: BoxDecoration(
                            //             color: index.isOdd
                            //                 ? const Color.fromARGB(
                            //                     95, 189, 182, 182)
                            //                 : Colors.white),
                            //         child: Row(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.center,
                            //           children: [
                            //             Expanded(
                            //                 child: Text(
                            //               data.name.toString(),
                            //               style: detailText16,
                            //             )),
                            //             Expanded(
                            //                 child: Text(
                            //               data.options
                            //                   .toString()
                            //                   .replaceAll('[', '')
                            //                   .replaceAll(']', ''),
                            //               style: detailText16,
                            //             )),
                            //           ],
                            //         ),
                            //       );
                            //     }),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      TitleBar(
                        title: 'Review',
                        callback: () {
                          print('ok');
                          setState(() {
                            review = review ? false : true;
                          });
                        },
                        up: review,
                      ),
                      GetBuilder<OnlineProductFilterController>(
                          builder: (reviewcontroller) {
                        return Visibility(
                          visible: review,
                          child: SizedBox(
                              height: 90 *
                                  double.parse(reviewcontroller.review.length
                                      .toString()),
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: reviewcontroller.review.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (_, index) {
                                    reviewModel data =
                                        reviewcontroller.review[index];
                                    return Container(
                                      height: 90,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: index.isOdd
                                              ? Colors.black38
                                              : Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  data.reviewer.toString(),
                                                  style: headerText3.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              RatingBarIndicator(
                                                itemSize: 22,
                                                rating: double.parse(
                                                    data.rating.toString()),
                                                direction: Axis.horizontal,
                                                //allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Html(
                                            data: data.review,
                                            style: {
                                              "p": Style(
                                                  fontSize: FontSize.larger)
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  })),
                        );
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      //
                      //Related product
                      const Center(
                        child: Text(
                          'Related Products',
                          style: headerText3,
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      GetBuilder<OnlineProductFilterController>(
                          builder: (productfiltercontroller) {
                        return productfiltercontroller.onrelativeproductloding
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                height: 330,
                                child: ShimmerProgress(
                                  item: 2,
                                ))
                            : SizedBox(
                                height: 330.0 *
                                    (productfiltercontroller
                                            .mainproduct.length.isEven
                                        ? productfiltercontroller
                                            .mainproduct.length
                                        : productfiltercontroller
                                                .mainproduct.length +
                                            1) /
                                    2,
                                child: MainProductWidget(
                                  data: productfiltercontroller.mainproduct,
                                ));
                      }),
                      Visibility(
                        visible: pcontroller.progress,
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
                top: 0,
                child: ProductAppbar(
                  product: product!,
                ))
          ],
        );
      }),
      bottomNavigationBar: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.offAllNamed('/back/homepage');
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FaIcon(
                      FontAwesomeIcons.home,
                      color: Theme.of(context).focusColor,
                      size: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    contact = contact ? false : true;
                  });
                },
                child: const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FaIcon(
                    FontAwesomeIcons.phone,
                    color: Colors.blueAccent,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GetBuilder<CartController>(builder: (cartcontroller) {
                return Expanded(
                    child: GestureDetector(
                  onTap: () {
                    //buy Now
                    if (product!.stockStatus == 'instock') {
                      if (tagname) {
                        if (cartcontroller.state == 'BD-12' ||
                            cartcontroller.state == 'BD-BD-39') {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => Container(
                              height: MediaQuery.of(context).size.height * 0.75,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                ),
                              ),
                              child: VeriationProduct(
                                product: product!,
                                src: _productimage[0].src!,
                                vid: 0,
                                variation_value: '',
                                oncheck: onveriation,
                                tagname: tagname,
                                tagstatus: tagstatus,
                              ),
                            ),
                          );
                        } //end of state check
                        else {
                          Get.defaultDialog(
                              title: "Sorry !!",
                              middleText:
                                  "Product is not Available In your Location ",
                              backgroundColor: Color.fromARGB(255, 255, 23, 23),
                              titleStyle: const TextStyle(color: Colors.white),
                              middleTextStyle:
                                  const TextStyle(color: Colors.white),
                              radius: 30,
                              actions: [
                                Container(
                                  child: TextButton(
                                    onPressed: () {
                                      Get.back();

                                      // Get.offAndToNamed('/login');
                                      //Get.off(LoginPage());
                                    },
                                    child: Center(
                                      child: Text(
                                        'OK',
                                        style: detailText18.copyWith(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ]);
                        }
                      } //tagname if else
                      else {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0),
                              ),
                            ),
                            child: VeriationProduct(
                              product: product!,
                              src: _productimage[0].src!,
                              vid: 0,
                              variation_value: '',
                              oncheck: onveriation,
                              tagname: tagname,
                              tagstatus: tagstatus,
                            ),
                          ),
                        );
                      }
                    } else {
                      Get.defaultDialog(
                          title: "Sorry !!",
                          middleText: "Product is not Available. "
                              "Please try again latter",
                          backgroundColor: Color.fromARGB(255, 255, 23, 23),
                          titleStyle: const TextStyle(color: Colors.white),
                          middleTextStyle: const TextStyle(color: Colors.white),
                          radius: 30,
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();

                                // Get.offAndToNamed('/login');
                                //Get.off(LoginPage());
                              },
                              child: Center(
                                child: Text(
                                  'OK',
                                  style: detailText18.copyWith(
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ]);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: MediaQuery.of(context).size.width / 3.2,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).focusColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'Buy Now',
                      style: detailText16.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ),
                ));
              }),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  CartController cartcontroller = Get.find();
                  if (product!.stockStatus == 'instock') {
                    if (tagname) {
                      if (cartcontroller.state == 'BD-12' ||
                          cartcontroller.state == 'BD-BD-39') {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0),
                              ),
                            ),
                            child: VeriationProduct(
                              product: product!,
                              src: _productimage[0].src!,
                              vid: 0,
                              variation_value: '',
                              oncheck: onveriation,
                              tagname: tagname,
                              tagstatus: tagstatus,
                            ),
                          ),
                        );
                      } //end of state check
                      else {
                        Get.defaultDialog(
                            title: "Sorry !!",
                            middleText:
                                "Product is not Available In your Location ",
                            backgroundColor: Color.fromARGB(255, 255, 23, 23),
                            titleStyle: const TextStyle(color: Colors.white),
                            middleTextStyle:
                                const TextStyle(color: Colors.white),
                            radius: 30,
                            actions: [
                              Container(
                                child: TextButton(
                                  onPressed: () {
                                    Get.back();

                                    // Get.offAndToNamed('/login');
                                    //Get.off(LoginPage());
                                  },
                                  child: Center(
                                    child: Text(
                                      'OK',
                                      style: detailText18.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ]);
                      }
                    } //tagname if else
                    else {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.75,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          child: VeriationProduct(
                            product: product!,
                            src: _productimage[0].src!,
                            vid: 0,
                            variation_value: '',
                            oncheck: onveriation,
                            tagname: tagname,
                            tagstatus: tagstatus,
                          ),
                        ),
                      );
                    }
                  } else {
                    Get.defaultDialog(
                        title: "Sorry !!",
                        middleText: "Product is not Available. "
                            "Please try again latter",
                        backgroundColor: Color.fromARGB(255, 255, 23, 23),
                        titleStyle: const TextStyle(color: Colors.white),
                        middleTextStyle: const TextStyle(color: Colors.white),
                        radius: 30,
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();

                              // Get.offAndToNamed('/login');
                              //Get.off(LoginPage());
                            },
                            child: Center(
                              child: Text(
                                'OK',
                                style:
                                    detailText18.copyWith(color: Colors.white),
                              ),
                            ),
                          )
                        ]);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width / 3.2,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(120, 245, 212, 206),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'Add to Cart',
                    style: detailText16.copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: contact,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 25,
          color: Color.fromARGB(255, 236, 202, 199),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () async {
                    await launchUrl(Uri.parse(Server.facebook),
                        mode: LaunchMode.externalApplication,
                        webViewConfiguration: WebViewConfiguration(
                          headers: <String, String>{
                            'header_key': 'header_value'
                          },
                        )

                        // webViewConfiguration: const WebViewConfiguration(
                        //     headers: <String, String>{
                        //       'my_header_key': 'my_header_value'
                        //     }),
                        );
                  },
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.facebook,
                      size: 28,
                      color: Colors.blue,
                    ),
                  ),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () async {
                    final phoneNumber =
                        ''; // replace with the phone number you want to message
                    final message =
                        'Hello'; // replace with the message you want to send

                    final whatsappUrl =
                        'https://wa.me/${Server.whatsapp}?text=$message';

                    if (await canLaunch(whatsappUrl)) {
                      await launch(whatsappUrl);
                    } else {
                      throw 'Could not launch $whatsappUrl';
                    }
                  },
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      size: 28,
                      color: Colors.green,
                    ),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () async {
                    final Uri launchUri = Uri(
                      scheme: 'tel',
                      path: Server.phone,
                    );
                    await launchUrl(launchUri);
                  },
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.squarePhone,
                      size: 28,
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
