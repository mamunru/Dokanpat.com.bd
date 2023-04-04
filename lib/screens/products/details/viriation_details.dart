import 'package:another_flushbar/flushbar.dart';
import 'package:dokanpat/widgets/images/network_images.dart';
import 'package:dokanpat/widgets/title_bar.dart';
import 'package:flutter/material.dart';

import '../../../configs/server.dart';
import '../../../configs/themes/custome_text_style.dart';
import '../../../controllers/cartController.dart';
import 'package:get/get.dart';

import '../../../model/product_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VeriationProduct extends StatefulWidget {
  productModel product;
  String src;
  int vid;
  bool oncheck;
  bool tagname;
  bool tagstatus;

  String variation_value;
  VeriationProduct(
      {required this.product,
      required this.src,
      required this.vid,
      required this.variation_value,
      required this.oncheck,
      required this.tagname,
      required this.tagstatus,
      //required this.onveriation,
      super.key});

  @override
  State<VeriationProduct> createState() => _VeriationProductState(
      product: product,
      src: src,
      variation_value: variation_value,
      vid: vid,
      tagname: tagname,
      tagstatus: tagstatus);
}

class _VeriationProductState extends State<VeriationProduct> {
  productModel product;
  String src;
  int vid;
  bool tagname;
  bool tagstatus;
  String variation_value;

  _VeriationProductState(
      {required this.product,
      required this.src,
      required this.variation_value,
      required this.vid,
      required this.tagname,
      required this.tagstatus});

  bool description = true;
  bool review = true;
  bool info = true;
  bool color = false;
  bool selectvaration = false;
  int qty = 1;
  bool onveriation = false;
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    CartController cartcontroll = Get.find();
    // print(cartcontroll.state);
    product.tags!.forEach((v) {
      if (v.name.toString().toLowerCase() == Server.tagname.toLowerCase()) {
        setState(() {
          tagname = true;
          tagstatus = true;
        });
      }
    });
    if (product.variationProducts != null) {
      setState(() {
        onveriation = true;
        // vid = 1;
      });
    }
    super.initState();
  }

  //String src = '';

  @override
  Widget build(BuildContext context) {
    //CartController cartcontroll = Get.find();
    _textController = TextEditingController(text: qty.toString());
    _textController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textController.text.length));

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        actions: [
          SizedBox(
            //height: 30,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned(
                    top: 10,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.xmark,
                        color: Colors.red,
                        size: 22,
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(5),
            // height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: NetworkCatchImage(
                        imagekey: src,
                        image: src,
                        height: 150,
                        width: 150,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            product.name.toString(),
                            style: detailText16,
                          ),
                          Text(
                            'Price = ' + product.price.toString() + ' TK',
                            style: detailText16.copyWith(color: Colors.red),
                          ),
                          Text(
                            'Regular Price = ' +
                                product.regularPrice.toString() +
                                'TK',
                            style: detailText16.copyWith(
                                decoration:
                                    double.parse(product.price.toString()) <
                                            double.parse(
                                                product.regularPrice.toString())
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none),
                          ),
                          Visibility(
                            visible: variation_value.toString().length > 2,
                            child: Text(
                              'Veriation = ' + variation_value.toString(),
                              style: detailText16.copyWith(),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                onveriation == false
                    ? Container()
                    : Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product
                                  .variationProducts![0].attributesArr![0].name
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
                                children:
                                    product.variationProducts!.map((data) {
                                  return InkWell(
                                    onTap: (() {
                                      setState(() {
                                        selectvaration = true;
                                        product.price = data.price;

                                        product.regularPrice =
                                            data.regularPrice;
                                        product.stockStatus = data.stockStatus;
                                        vid = data.id!;
                                        variation_value = data
                                            .attributesArr![0].attributeName
                                            .toString();

                                        src = data.featureImage.toString();
                                        product.images![0].src =
                                            data.featureImage.toString();
                                        product.images![0].name =
                                            data.id.toString();
                                      });
                                    }),
                                    child: Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      margin: const EdgeInsets.only(
                                          right: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          color: vid !=
                                                  int.parse(data.id.toString())
                                              ? const Color.fromARGB(
                                                  31, 124, 117, 117)
                                              : Theme.of(context).focusColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Center(
                                          child: Text(
                                            data.attributesArr![0].attributeName
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
                Container(
                  height: 35,
                  //padding: const EdgeInsets.only(bottom: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: Text(
                            'Select The Quantity',
                            style: detailText15,
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (qty > 1) {
                                      qty -= 1;
                                    }
                                  });
                                },
                                child: Container(
                                  height: 28,
                                  width: 28,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(76, 233, 169, 169),
                                  ),
                                  child: const FaIcon(
                                    FontAwesomeIcons.minus,
                                    color: Color.fromARGB(255, 247, 124, 124),
                                    size: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 90,
                                height: 28,
                                alignment: Alignment.center,
                                // decoration: BoxDecoration(border: Border.all()),
                                child: TextField(
                                  controller: _textController,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    // border around the text field
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) async {
                                    if (value.length == 0) {
                                      await Future.delayed(
                                              const Duration(seconds: 2))
                                          .then((_) {
                                        if (_textController.text.length == 0 ||
                                            _textController.text == '0') {
                                          setState(() {
                                            qty = 1;
                                            _textController.text = '1';
                                          });
                                        }
                                      });
                                    } else {
                                      setState(() {
                                        qty = int.parse(_textController.text);
                                      });
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    qty += 1;
                                  });
                                },
                                child: Container(
                                  height: 28,
                                  width: 28,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(76, 233, 169, 169),
                                  ),
                                  child: const FaIcon(
                                    FontAwesomeIcons.plus,
                                    color: Color.fromARGB(255, 247, 124, 124),
                                    size: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            )),
      ),
      bottomNavigationBar: product.stockStatus == 'instock'
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: selectvaration == false && onveriation && vid == 0
                  ? Container(
                      height: 36,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Please Select ' +
                              product
                                  .variationProducts![0].attributesArr![0].name
                                  .toString()
                                  .replaceAll('pa_', ''),
                          style: detailText16.copyWith(color: Colors.red),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            GetBuilder<CartController>(
                                builder: (cartcontroller) {
                              return InkWell(
                                onTap: () {
                                  //buy Now
                                  if (product.stockStatus == 'instock') {
                                    if (tagname) {
                                      if (cartcontroller.state == 'BD-12' ||
                                          cartcontroller.state == 'BD-BD-39') {
                                        cartcontroller.directshopping(
                                            product.id!,
                                            product.name!,
                                            product.price!,
                                            product.regularPrice!,
                                            qty,
                                            vid,
                                            variation_value,
                                            src,
                                            tagstatus);
                                      } else {
                                        Get.defaultDialog(
                                            title: "Sorry !!",
                                            middleText:
                                                "Product is not Available In your Location ",
                                            backgroundColor: Color.fromARGB(
                                                255, 255, 23, 23),
                                            titleStyle: const TextStyle(
                                                color: Colors.white),
                                            middleTextStyle: const TextStyle(
                                                color: Colors.white),
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
                                                      style:
                                                          detailText18.copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ]);
                                      }
                                    } //end tag name
                                    else {
                                      cartcontroller.directshopping(
                                          product.id!,
                                          product.name!,
                                          product.price!,
                                          product.regularPrice!,
                                          qty,
                                          vid,
                                          variation_value,
                                          src,
                                          tagstatus);
                                    }
                                  } else {
                                    Get.defaultDialog(
                                        title: "Sorry !!",
                                        middleText: "Product is not Available. "
                                            "Please try again latter",
                                        backgroundColor:
                                            Color.fromARGB(255, 255, 23, 23),
                                        titleStyle: const TextStyle(
                                            color: Colors.white),
                                        middleTextStyle: const TextStyle(
                                            color: Colors.white),
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
                                                    style:
                                                        detailText18.copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ]);
                                  }
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  width:
                                      MediaQuery.of(context).size.width / 2.1,
                                  height: 36,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).focusColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    'Buy Now',
                                    style: detailText16.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: InkWell(
                              onTap: () async {
                                Get.back();
                                CartController cartcontroller = Get.find();
                                if (product.stockStatus == 'instock') {
                                  if (tagname) {
                                    if (cartcontroller.state == 'BD-12' ||
                                        cartcontroller.state == 'BD-BD-39') {
                                      cartcontroller.addcart(
                                          product.id!,
                                          product.name!,
                                          product.price!,
                                          product.regularPrice!,
                                          qty,
                                          vid,
                                          variation_value,
                                          src,
                                          tagstatus);

                                      // ignore: avoid_single_cascade_in_expression_statements
                                      Flushbar(
                                        flushbarPosition: FlushbarPosition.TOP,
                                        backgroundColor: Colors.red,
                                        // padding: const EdgeInsets.only(left: 20),
                                        title: 'Thank You !!',
                                        message: product.name! + " Add To Cart",

                                        duration: Duration(seconds: 3),
                                      )..show(context);
                                    } else {
                                      Get.defaultDialog(
                                          title: "Sorry !!",
                                          middleText:
                                              "Product is not Available In your Location ",
                                          backgroundColor:
                                              Color.fromARGB(255, 255, 23, 23),
                                          titleStyle: const TextStyle(
                                              color: Colors.white),
                                          middleTextStyle: const TextStyle(
                                              color: Colors.white),
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
                                                    style:
                                                        detailText18.copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]);
                                    }
                                  } else {
                                    cartcontroller.addcart(
                                        product.id!,
                                        product.name!,
                                        product.price!,
                                        product.regularPrice!,
                                        qty,
                                        vid,
                                        variation_value,
                                        src,
                                        tagstatus);

                                    // ignore: avoid_single_cascade_in_expression_statements
                                    Flushbar(
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Colors.red,
                                      // padding: const EdgeInsets.only(left: 20),
                                      title: 'Thank You !!',
                                      message: product.name! + " Add To Cart",

                                      duration: Duration(seconds: 3),
                                    )..show(context);
                                  }
                                } else {
                                  Get.defaultDialog(
                                      title: "Sorry !!",
                                      middleText: "Product is not Available. "
                                          "Please try again latter",
                                      backgroundColor:
                                          Color.fromARGB(255, 255, 23, 23),
                                      titleStyle:
                                          const TextStyle(color: Colors.white),
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
                                            child: Container(
                                              height: 30,
                                              width: 200,
                                              child: Center(
                                                child: Text(
                                                  'OK',
                                                  style: detailText18.copyWith(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ]);
                                }
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                width: MediaQuery.of(context).size.width / 2.1,
                                height: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        120, 236, 218, 218),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  'ADD TO CART',
                                  style: detailText16.copyWith(
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
            )
          : SizedBox(
              height: 35,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'Product is not Available !!',
                  style: detailText18.copyWith(color: Colors.red),
                ),
              ),
            ),
    );
  }
}
