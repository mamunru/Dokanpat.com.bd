import 'package:dokanpat/configs/demodata/product.dart';
import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/cartController.dart';
import 'package:dokanpat/controllers/loginController.dart';
import 'package:flutter/material.dart';

import '../cart/cart_products.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black, size: 20),
        centerTitle: true,
        title: Text('My Cart'),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<CartController>(builder: (cartcontroller) {
          return Container(
              height: MediaQuery.of(context).size.height - 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cartcontroller.cartlist.isEmpty
                      ? Container(
                          height: MediaQuery.of(context).size.height - 200,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/empty_search.png')),
                          ),
                          child: Text(
                            "Empty Cart",
                            style: headerText.copyWith(),
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child: CartProducts()),
                ],
              ));
        }),
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: GetBuilder<CartController>(builder: (cartcontroller) {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  cartcontroller.addall();
                },
                child: Container(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 25,
                        width: 25,
                        child: cartcontroller.cartlist.length ==
                                    cartcontroller.selecteditems.length &&
                                cartcontroller.total != 0
                            ? const FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                color: Colors.red,
                                size: 22,
                              )
                            : const FaIcon(
                                FontAwesomeIcons.circle,
                                size: 22,
                              ),
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(50),
                        //     border: Border.all()),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'All',
                        style: headerText3,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      // RichText(
                      //     text: TextSpan(
                      //         text: 'Delivery: ',
                      //         style: detailText16,
                      //         children: [
                      //       TextSpan(
                      //           text: '60',
                      //           style: detailText16.copyWith(color: Colors.red))
                      //     ])),
                      RichText(
                          text: TextSpan(
                              text: 'Total : ',
                              style: headerText2.copyWith(
                                  fontWeight: FontWeight.w400),
                              children: [
                            TextSpan(
                                text: cartcontroller.total.toString(),
                                style: headerText2.copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400))
                          ]))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GetBuilder<loginController>(builder: (logincontroll) {
                bool notchangeState = false;
                String pname = '';
                cartcontroller.selecteditems.forEach(
                  (element) {
                    if (element.tagstatus == true) {
                      if (cartcontroller.state == 'BD-12' ||
                          cartcontroller.state == "BD-39") {
                        notchangeState = false;
                        pname += element.name.toString() + ', ';
                      } else {
                        notchangeState = true;
                        pname += element.name.toString() + ', ';
                      }
                    }
                  },
                );
                return GestureDetector(
                  onTap: () {
                    if (cartcontroller.total > 0) {
                      if (notchangeState) {
                        Get.defaultDialog(
                          title: "Warnning !!",
                          middleText: "$pname "
                              " not available in your Location ",
                          backgroundColor: Theme.of(context).focusColor,
                          titleStyle: TextStyle(color: Colors.white),
                          middleTextStyle: TextStyle(color: Colors.white),
                        );
                      } else {
                        if (logincontroll.wootoken!.length > 10) {
                          Get.toNamed('/checkout');
                          cartcontroller.pageindex = 0;
                        } else {
                          Get.toNamed('/buynow/login');
                          cartcontroller.pageindex = 0;
                        }
                      }
                    } else {
                      Get.defaultDialog(
                        title: "No Product is Seleted !!",
                        middleText: "Please Select Product",
                        backgroundColor: Theme.of(context).focusColor,
                        titleStyle: TextStyle(color: Colors.white),
                        middleTextStyle: TextStyle(color: Colors.white),
                      );
                    }
                  },
                  child: Card(
                    //borderOnForeground: true,
                    child: Container(
                      //margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 45,
                      width: MediaQuery.of(context).size.width / 3,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).focusColor,
                      ),
                      child: Text(
                        'Check Out',
                        style: headerText3.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}
