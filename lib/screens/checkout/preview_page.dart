// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:dokanpat/controllers/cartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/custome_text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/images/network_images.dart';

class PreviewPage extends StatelessWidget {
  PreviewPage({super.key});

  //bool delivery = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartcontroller) {
      return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // InkWell(
                //   onTap: () {
                //     setState(() {
                //       delivery = delivery ? false : true;
                //     });
                //   },
                //   child: Container(
                //     height: 35,
                //     width: MediaQuery.of(context).size.width,
                //     decoration: const BoxDecoration(
                //         color: Color.fromARGB(31, 119, 116, 116)),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const Expanded(
                //             child: Padding(
                //           padding: EdgeInsets.only(top: 6, left: 10),
                //           child: Text(
                //             'Delivery Address',
                //             style: headerText4,
                //             textAlign: TextAlign.justify,
                //           ),
                //         )),
                //         Padding(
                //           padding: const EdgeInsets.only(top: 6, right: 15),
                //           child: delivery
                //               ? const FaIcon(
                //                   FontAwesomeIcons.angleUp,
                //                   size: 20,
                //                 )
                //               : const FaIcon(
                //                   FontAwesomeIcons.angleRight,
                //                   size: 20,
                //                 ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Visibility(
                  visible: true,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: const Color.fromARGB(31, 163, 157, 157),
                    padding:
                        const EdgeInsets.only(left: 12, bottom: 10, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery To : ' +
                              cartcontroller.first_name +
                              ' ' +
                              cartcontroller.last_name,
                          style: headerText3,
                        ),
                        Text(
                          '' +
                              cartcontroller.address +
                              ' ,' +
                              cartcontroller.statename +
                              ', Bangladesh, ' +
                              cartcontroller.phone,
                          style: headerText3,
                        ),
                      ],
                    ),
                    // child: Column(
                    //   children: [
                    //     Row(
                    //       // crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         const Expanded(
                    //             child: Text(
                    //           'Name : ',
                    //           style: detailText16,
                    //         )),
                    //         Expanded(
                    //             child: Text(
                    //                 cartcontroller.first_name +
                    //                     ' ' +
                    //                     cartcontroller.last_name,
                    //                 style: detailText16))
                    //       ],
                    //     ),
                    //     Row(
                    //       // crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         const Expanded(
                    //             child: Text(
                    //           'phone : ',
                    //           style: detailText16,
                    //         )),
                    //         Expanded(
                    //             child: Text(cartcontroller.phone,
                    //                 style: detailText16))
                    //       ],
                    //     ),
                    //     Row(
                    //       // crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         const Expanded(
                    //             child: Text(
                    //           'District : ',
                    //           style: detailText16,
                    //         )),
                    //         Expanded(
                    //             child: Text(cartcontroller.statename,
                    //                 style: detailText16))
                    //       ],
                    //     ),
                    //     Row(
                    //       // crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         const Expanded(
                    //             child: Text(
                    //           'Address : ',
                    //           style: detailText16,
                    //         )),
                    //         Expanded(
                    //             child: Text(cartcontroller.address,
                    //                 style: detailText16)),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  ),
                ),

                //Order Details
                const Divider(),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  child: const Text(
                    'Oder Details',
                    style: headerText3,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cartcontroller.selecteditems.map((data) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 110,
                            width: 110,
                            child: NetworkCatchImage(
                                imagekey: data.name,
                                image: data.src.toString(),
                                height: 110),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            //width: MediaQuery.of(context).size.width / 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  //height: 24,
                                  child: Text(
                                    data.name.toString(),
                                    style: detailText18.copyWith(),
                                    maxLines: 3,
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      data.variation_id! < 1 ? false : true,
                                  child: Container(
                                    child: Text(
                                      'Veriations = ' +
                                          data.variationValue.toString(),
                                      style: detailText16,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Price = " +
                                                (double.parse(
                                                        data.price.toString()))
                                                    .toString() +
                                                " TK & Quantity = " +
                                                data.quantity.toString(),
                                            style: detailText16.copyWith(
                                              color: Colors.black,
                                            )),
                                        Text(
                                            "Total = " +
                                                (double.parse(data.price
                                                            .toString()) *
                                                        int.parse(data.quantity
                                                            .toString()))
                                                    .toString() +
                                                " TK",
                                            style: detailText16.copyWith(
                                              color: Colors.red,
                                            )),
                                        // Text(
                                        //     "Quantity = " +
                                        //         data.quantity.toString(),
                                        //     style: detailText16.copyWith(
                                        //       color: Colors.black,
                                        //     )),
                                      ],
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 2,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                        child: TextField(
                            decoration: InputDecoration(
                      hintText: 'Enter your Coupon',
                      labelText: 'Coupons',
                    ))),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      child: Card(
                        //color: Color.fromARGB(77, 243, 243, 243),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: 45,
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.red,
                                size: 20,
                              ),
                              Text(
                                ' Apply',
                                style: detailText16.copyWith(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                              child: Text(
                            'subtotal',
                            style: detailText16,
                          )),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text(
                              cartcontroller.total.toString() + " TK",
                              style: detailText16,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              child: Text(
                            'Delivery Change',
                            // cartcontroller
                            //     .shoppingmethods[
                            //         cartcontroller.shopping_methodsindex]
                            //     .title
                            //     .toString(),
                            style: detailText16,
                          )),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text(
                              cartcontroller
                                      .shoppingmethods[
                                          cartcontroller.shopping_methodsindex]
                                      .settings!
                                      .cost!
                                      .value
                                      .toString() +
                                  " TK",
                              style: detailText16,
                              maxLines: 2,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              child: Text(
                            'Total',
                            style: headerText3,
                          )),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text(
                              cartcontroller.final_total.toString() + " TK",
                              style: headerText3,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
        bottomNavigationBar: InkWell(
          onTap: () {
            cartcontroller.ChangepageIndex();
            //cartcontroller.PaymentList();
            //controller.CreateOrder();

            // if (_formKey.currentState!.validate()) {
            //   // If the form is valid, display a Snackbar.\
            //   print(firstname.text);
            // }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 5),
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).focusColor,
              //borderRadius: BorderRadius.circular(50)
            ),
            child: Center(
              child: Text(
                'Continue'.toString().toUpperCase(),
                style: headerText3.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      );
    });
  }
}
