import 'dart:math';

import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/orderhistory_controller.dart';
import 'package:dokanpat/widgets/empty_page.dart';
import 'package:dokanpat/widgets/images/network_images.dart';
import 'package:dokanpat/widgets/progress/shimmer_prograss.dart';
import 'package:dokanpat/widgets/reviewpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:dokanpat/configs/state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderHistory extends StatefulWidget {
  OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final ScrollController _scrollController = ScrollController();

  var now = Jiffy().format("yyyy-MM-dd HH:mm:ss");
  double rating = 0;

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
    OrderHistoryContriller ordercontroller = Get.find();
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      ordercontroller.getmyorderupdate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle(
        //   // Status bar color
        //   statusBarColor: Colors.transparent,

        //   // Status bar brightness (optional)
        //   statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
        // ),

        iconTheme: const IconThemeData(color: Colors.black),
        // backgroundColor: Colors.red,
        title: Text('My Order'),
        centerTitle: true,
      ),
      body:
          GetBuilder<OrderHistoryContriller>(builder: (orderhistorycontroller) {
        return SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Container(
                child: orderhistorycontroller.onloading
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        child: ShimmerProgress(),
                      )
                    : orderhistorycontroller.orderhistory.value.isEmpty
                        ? EmptyPage(
                            title: 'No Order Found',
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: orderhistorycontroller.orderhistory.value
                                .asMap()
                                .entries
                                .map((element) {
                              bool check = element.value.lineItems!.isNotEmpty;

                              return Visibility(
                                visible: check,
                                child: Container(
                                  color:
                                      const Color.fromARGB(23, 216, 204, 204),
                                  width: MediaQuery.of(context).size.width,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        'Order ' + element.value.id.toString(),
                                        style: headerText3,
                                      ),
                                      Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        'Total ' +
                                            element.value.total.toString() +
                                            ' TK',
                                        style: detailText16.copyWith(
                                            color: Colors.black),
                                      ),
                                      Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        'Status = ' +
                                            element.value.status.toString(),
                                        style: detailText16.copyWith(
                                            color: Color.fromARGB(
                                                255, 4, 90, 238)),
                                      ),
                                      Text(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          'Address ' +
                                              element.value.shipping!.firstName
                                                  .toString() +
                                              ' ' +
                                              element.value.shipping!.lastName
                                                  .toString() +
                                              ',${element.value.shipping!.address1.toString()}, ${element.value.shipping!.phone.toString()}',
                                          style: detailText15.copyWith(
                                            color: Colors.black,
                                          )),
                                      Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        'Payment on ' +
                                            element.value.paymentMethod
                                                .toString()
                                                .toUpperCase(),
                                        style: detailText14.copyWith(
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        'Placed on ' +
                                            Jiffy(element.value.dateCreated
                                                    .toString())
                                                .yMMMEdjm
                                                .toString(),
                                        style: detailText14.copyWith(
                                            color: Colors.black54),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                          child: Column(
                                              children: element.value.lineItems!
                                                  .asMap()
                                                  .entries
                                                  .map((e) {
                                        bool image =
                                            e.value.image.toString().length > 5;
                                        bool name =
                                            e.value.name.toString().length > 5;
                                        bool price =
                                            e.value.price.toString().length > 0;
                                        return Visibility(
                                          visible: image && name && price,
                                          child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      int catid = e
                                                                  .value
                                                                  .productData!
                                                                  .categories!
                                                                  .length >
                                                              0
                                                          ? Random().nextInt(e
                                                              .value
                                                              .productData!
                                                              .categories!
                                                              .length)
                                                          : 0;
                                                      Get.toNamed(
                                                          '/product_details/${e.value.productData!.id}/${e.value.productData!.categories![catid].id}',
                                                          arguments: e.value
                                                              .productData!);
                                                    },
                                                    child: SizedBox(
                                                      width: 100,
                                                      height: 100,
                                                      child: NetworkCatchImage(
                                                        imagekey: e.value.name
                                                            .toString(),
                                                        image: e
                                                            .value.image!.src
                                                            .toString(),
                                                        height: 100,
                                                        width: 100,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            int catid = e
                                                                        .value
                                                                        .productData!
                                                                        .categories!
                                                                        .length >
                                                                    0
                                                                ? Random().nextInt(e
                                                                    .value
                                                                    .productData!
                                                                    .categories!
                                                                    .length)
                                                                : 0;
                                                            Get.toNamed(
                                                                '/product_details/${e.value.productData!.id}/${e.value.productData!.categories![catid].id}',
                                                                arguments: e
                                                                    .value
                                                                    .productData!);
                                                          },
                                                          child: Text(
                                                            e.value.name
                                                                .toString(),
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Price ' +
                                                              e.value.price
                                                                  .toString() +
                                                              ' TK',
                                                          maxLines: 2,
                                                        ),
                                                        Text(
                                                          'Quantity x' +
                                                              e.value.quantity
                                                                  .toString(),
                                                          maxLines: 2,
                                                        ),
                                                        Text(
                                                          'Total ' +
                                                              e.value.total
                                                                  .toString()
                                                                  .toString() +
                                                              ' TK',
                                                          maxLines: 2,
                                                        ),
                                                        element.value.status ==
                                                                'completed'
                                                            ? double.parse(element
                                                                        .value
                                                                        .totalTax
                                                                        .toString()) >
                                                                    0.0
                                                                ? Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            2),
                                                                    child:
                                                                        RatingBarIndicator(
                                                                      rating: double.parse(element
                                                                          .value
                                                                          .totalTax
                                                                          .toString()),
                                                                      itemBuilder:
                                                                          (context, index) =>
                                                                              Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: Colors
                                                                            .amber,
                                                                      ),
                                                                      itemCount:
                                                                          5,
                                                                      itemSize:
                                                                          15.0,
                                                                      direction:
                                                                          Axis.horizontal,
                                                                    ),
                                                                  )
                                                                : TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.bottomSheet(
                                                                          Container(
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            ReviewPage(
                                                                          productid: e
                                                                              .value
                                                                              .productId!,
                                                                        ),
                                                                      ));
                                                                    },
                                                                    child: Text(
                                                                      'Review',
                                                                      style: detailText16.copyWith(
                                                                          color:
                                                                              Theme.of(context).focusColor),
                                                                    ))
                                                            : Container()
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        );
                                      }).toList()))
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
              ),
              Container(
                child: Visibility(
                    visible: orderhistorycontroller.onupdate,
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    )),
              )
            ],
          ),
        );
      }),
    );
  }
}
