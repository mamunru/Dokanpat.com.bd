import 'package:dokanpat/controllers/cartController.dart';
import 'package:dokanpat/controllers/wishliatController.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../configs/themes/custome_text_style.dart';
import '../../model/product_model.dart';

class ProductAppbar extends StatelessWidget {
  productModel product;
  ProductAppbar({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        //color: Colors.white,
        margin: const EdgeInsets.only(top: 25),
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButton(),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed('/search');
                },
                child: Center(
                    child: Container(
                  width: MediaQuery.of(context).size.width * .59,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(150, 230, 227, 227),
                      //border: Border.all(width: 1)
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      FaIcon(FontAwesomeIcons.magnifyingGlass),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Search Here',
                        style: detailText16,
                      ),
                    ],
                  ),
                )),
              ),
              const SizedBox(
                width: 10,
              ),
              GetBuilder<WishListController>(builder: (wishListController) {
                int wish = wishListController.wishlistproduct.indexWhere(
                  (element) => element.id == product.id,
                );
                return Container(
                  child: GestureDetector(
                    onTap: () {
                      wishListController.adddata(product: product);
                    },
                    child: Center(
                        child: FaIcon(
                      FontAwesomeIcons.solidHeart,
                      size: 22,
                      color: wish >= 0 ? Colors.red : Colors.black,
                    )),
                  ),
                );
              }),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 50,
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
                                width: 60,
                                // decoration: BoxDecoration(
                                //     color: Color.fromARGB(77, 228, 143, 143)),
                                child: Text(
                                  cartcontroller.cartlist.length.toString(),
                                  style: headerText4.copyWith(
                                      fontSize: 14, color: Colors.red),
                                ))),
                        Center(
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
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
