import 'package:dokanpat/configs/demodata/product.dart';
import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/cartController.dart';
import 'package:dokanpat/controllers/onlineProductController.dart';
import 'package:dokanpat/model/cart_model.dart';
import 'package:dokanpat/widgets/images/network_images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CartProducts extends StatefulWidget {
  CartProducts({super.key});

  @override
  State<CartProducts> createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  String oldqty = '';
  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Color.fromARGB(76, 223, 220, 220),
      child: GetBuilder<CartController>(builder: (cartcontroller) {
        return ListView.builder(
            //physics: NeverScrollableScrollPhysics(),
            itemCount: cartcontroller.cartlist.length,
            itemBuilder: (_, index) {
              TextEditingController _textController = TextEditingController();

              _textController = TextEditingController(
                  text: cartcontroller.cartlist[index].quantity.toString());
              _textController.selection = TextSelection.fromPosition(
                  TextPosition(offset: _textController.text.length));
              cartModel data = cartcontroller.cartlist[index];
              return Card(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.width > 320 ? 140 : 150,
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            cartcontroller.selecteditem(
                                data.product_id!, index);
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            child: data.check!
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
                            //     color: data.check! ? Colors.white : Colors.blue,
                            //     border: Border.all(),
                            //     shape: BoxShape.circle),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.delete<OnlineProductFilterController>();
                            Get.toNamed(
                                '/cart/product_details/online/${data.product_id}/0',
                                arguments: data);
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            child: NetworkCatchImage(
                                imagekey: data.name,
                                image: data.src.toString(),
                                height: 100),
                          ),
                        ),
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
                              child: GestureDetector(
                                onTap: () {
                                  Get.delete<OnlineProductFilterController>();
                                  Get.toNamed(
                                      '/cart/product_details/online/${data.product_id}/0',
                                      arguments: data);
                                },
                                child: Text(
                                  data.name.toString() +
                                      MediaQuery.of(context)
                                          .size
                                          .width
                                          .toString(),
                                  style: detailText18.copyWith(),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: data.variation_id! < 1 ? false : true,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        "Price = " +
                                            data.price.toString() +
                                            " TK",
                                        style: headerText3.copyWith(
                                          color: Colors.red,
                                        )),
                                    Container(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: Text(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          'Regular Price = ' +
                                              double.parse(data.regularPrice
                                                      .toString())
                                                  .toStringAsFixed(2)
                                                  .toString() +
                                              ' TK',
                                          style: detailText14.copyWith(
                                              decoration: double.parse(data
                                                          .regularPrice
                                                          .toString()) >
                                                      double.parse(
                                                          data.price.toString())
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none),
                                        )),
                                    // SizedBox(
                                    //   height: 28,
                                    //   child: InkWell(
                                    //     child: Container(
                                    //       width:
                                    //           MediaQuery.of(context).size.width /
                                    //               3,
                                    //       height: 25,
                                    //       decoration:
                                    //           BoxDecoration(border: Border.all()),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                )),
                                GestureDetector(
                                  onTap: () {
                                    // cartcontroller.clearCart();
                                    cartcontroller.removeitem(
                                        index, data.product_id!);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: const FaIcon(
                                      FontAwesomeIcons.trash,
                                      size: 25,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 5),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        cartcontroller.minusquantity(
                                            index, data.product_id!);
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        // decoration: const BoxDecoration(
                                        //     color: Color.fromARGB(
                                        //         121, 185, 174, 175)),
                                        child: Center(
                                            child: FaIcon(
                                          color: Theme.of(context).focusColor,
                                          FontAwesomeIcons.solidSquareMinus,
                                          size: 25,
                                        )),
                                      ),
                                    ),
                                    Container(
                                      width: 60,
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
                                            oldqty = value;
                                            await Future.delayed(
                                                    const Duration(seconds: 2))
                                                .then((value) {
                                              if (_textController.text == "0" ||
                                                  _textController.text.length ==
                                                      0) {
                                                cartcontroller
                                                    .addquantitywithnumber(
                                                        index,
                                                        data.product_id!,
                                                        1);
                                              }
                                            });
                                          } else {
                                            cartcontroller
                                                .addquantitywithnumber(
                                                    index,
                                                    data.product_id!,
                                                    int.parse(
                                                        value.toString()));
                                          }
                                        },
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        cartcontroller.addquantity(
                                            index, data.product_id!);
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        // decoration: const BoxDecoration(
                                        //     color: Color.fromARGB(
                                        //         122, 185, 174, 175)),
                                        child: Center(
                                            child: FaIcon(
                                          color: Theme.of(context).focusColor,
                                          FontAwesomeIcons.solidSquarePlus,
                                          size: 25,
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // Container(
                      //   width: 50,
                      //   child: Center(
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         const SizedBox(
                      //           height: 10,
                      //         ),
                      //         Container(
                      //           height: 28,
                      //           width: 28,
                      //           decoration: BoxDecoration(
                      //               color: Color.fromARGB(121, 185, 174, 175)),
                      //           child: Center(
                      //               child: FaIcon(
                      //             FontAwesomeIcons.plus,
                      //             size: 15,
                      //           )),
                      //         ),
                      //         Container(
                      //           height: 40,
                      //           decoration: BoxDecoration(),
                      //           alignment: Alignment.center,
                      //           child: Text(
                      //             data.quantity.toString(),
                      //             style: detailText16,
                      //           ),
                      //         ),
                      //         Container(
                      //           height: 28,
                      //           width: 28,
                      //           decoration: BoxDecoration(
                      //               color: Color.fromARGB(122, 185, 174, 175)),
                      //           child: Center(
                      //               child: FaIcon(
                      //             FontAwesomeIcons.minus,
                      //             size: 15,
                      //           )),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
