// ignore_for_file: prefer_const_constructors

import 'package:dokanpat/controllers/cartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/custome_text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartcontroller) {
      return Scaffold(
        body: SingleChildScrollView(
            child: cartcontroller.paymentonloading
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 200,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  )
                : Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            cartcontroller.codorder();
                          },
                          child: Card(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: 80,
                                  child: Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.truck,
                                      size: 50,
                                      color: Colors.red,
                                    ),
                                  ),

                                  // decoration: const BoxDecoration(
                                  //     image: DecorationImage(
                                  //         image: AssetImage(
                                  //             'assets/images/cod.jpg'))
                                  //             ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                const Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: Text(
                                    'Cash On Delivery',
                                    style: headerText3,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            cartcontroller.CreateOrder();
                          },
                          child: Card(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: 80,
                                  child: Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.creditCard,
                                      size: 50,
                                      color: Colors.red,
                                    ),
                                  ),
                                  // decoration: const BoxDecoration(
                                  //     image: DecorationImage(
                                  //         image: AssetImage(
                                  //             'assets/images/pay.jpg')
                                  //             )),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 25),
                                  child: Text(
                                    'Online Payment',
                                    style: headerText3,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                      // children: controller.payment.asMap().entries.map((e) {
                      //   return Text(e.value.title!);
                      // }).toList(),
                    ),
                  )),
      );
    });
  }
}
