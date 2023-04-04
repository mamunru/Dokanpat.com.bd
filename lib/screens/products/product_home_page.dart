import 'package:dokanpat/configs/demodata/product.dart';
import 'package:dokanpat/configs/server.dart';
import 'package:dokanpat/configs/state.dart';
import 'package:dokanpat/configs/themes/app_light_theme.dart';
import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/configs/themes/ui_parameter.dart';
import 'package:dokanpat/controllers/cartController.dart';
import 'package:dokanpat/controllers/mydrawer_controller.dart';
import 'package:dokanpat/controllers/product_controller.dart';
import 'package:dokanpat/controllers/theme_controller.dart';
import 'package:dokanpat/screens/products/sub_product/main_product_widget.dart';
import 'package:dokanpat/widgets/images/network_images.dart';
import 'package:dokanpat/widgets/progress/shimmer_prograss.dart';
import 'package:dokanpat/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/token_controller.dart';
import '../../widgets/app_circle_button.dart';
import '../../widgets/appbar/search_appbar.dart';
import '../menu/menu_screen.dart';
import 'category/special_category.dart';
import 'sub_product/horizontal_3_product.dart';
import 'sub_product/horizontal_product_list.dart';
import 'sub_product/show_category.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductHomePage extends StatefulWidget {
  ProductHomePage({Key? key}) : super(key: key);

  @override
  State<ProductHomePage> createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {
  ScrollController _scrollController = ScrollController();
  //TokenController tokenController = Get.find();
  ProductController productcontroller = Get.find();
  final GlobalKey _scaffoldKey = new GlobalKey();

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
    // MyDrawerController themecontroller = Get.find();
    ProductController productcontroller = Get.find();
    // themecontroller.scrollController(_scrollController.offset);
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        productcontroller.mainproduct.length <= 150 &&
        productcontroller.progress == false) {
      productcontroller.updateRandomProduct();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: SearchAppbar(),
      ),
      drawer: MenuScreen(),
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.red,
        strokeWidth: 2.0,
        onRefresh: () async {
          ProductController productController = Get.find();
          TokenController tokenController = Get.find();

          productcontroller.reloadfunction();
          tokenController.reloadfunction();
          // ignore: avoid_single_cascade_in_expression_statements
          Flushbar(
            // padding: const EdgeInsets.only(left: 20),
            backgroundColor: Colors.red,
            title: "Please Wait... ",
            messageText: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Loading ...',
                  style: detailText16.copyWith(color: Colors.white),
                )
              ],
            ),
            showProgressIndicator: true,
            //icon: Center(child: CircularProgressIndicator(Theme.of(context).focusColor,)),
            duration: Duration(seconds: 2),
          )..show(context);
          // show()
        },
        child: Stack(
          children: [
            //PositionedTransition(rect: rect, child: child)
            CustomScrollView(
              // scrollDirection: Axis.vertical,
              controller: _scrollController,

              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Section
                      //Image Slider Section
                      // SizedBox(
                      //   height: 75,
                      //   child: SearchAppbar(),
                      // ),
                      SizedBox(
                          height: 190,
                          child: Stack(
                            children: [
                              ImageSlider(165),
                              Positioned(
                                  bottom: 0,
                                  left: 30,
                                  child: GetBuilder<CartController>(
                                      builder: (cartcontroller) {
                                    return InkWell(
                                      onTap: () {
                                        print('ok');
                                        Get.bottomSheet(Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .55,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.white,
                                          child: ListView.builder(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              itemCount: Bdstate.length,
                                              itemBuilder: (_, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    print(
                                                        Bdstate[index]['name']);
                                                    cartcontroller.setlocaton(
                                                        Bdstate[index]['name'],
                                                        Bdstate[index]['id']);
                                                    Get.back();
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    child: Center(
                                                      child: Text(
                                                        Bdstate[index]['name'],
                                                        style: detailText16,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ));
                                      },
                                      child: Card(
                                        child: Container(
                                          height: 35,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .80,
                                          //color: Colors.red,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: FaIcon(
                                                  FontAwesomeIcons.locationPin,
                                                  size: 16,
                                                  color: Theme.of(context)
                                                      .focusColor,
                                                ),
                                              ),
                                              const VerticalDivider(
                                                color: Colors.black,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                  cartcontroller.statename,
                                                  style: detailText16,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }))
                            ],
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      GetBuilder<TokenController>(builder: (tokencontroll) {
                        return Visibility(
                          visible:
                              tokencontroll.category.isEmpty ? false : true,
                          child: SizedBox(
                            height: 280,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // height: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Expanded(
                                            child: Text(
                                          'Category',
                                          style: detailText16,
                                        )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Builder(builder: (context) {
                                            return GestureDetector(
                                              onTap: () {
                                                //Get.toNamed('/all/category');
                                                Scaffold.of(context)
                                                    .openDrawer();
                                              },
                                              child: Container(
                                                  child: Text(
                                                'See All',
                                                style: smallText.copyWith(
                                                  color: Theme.of(context)
                                                      .focusColor,
                                                ),
                                              )),
                                            );
                                          }),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: 250,
                                    child: ShowCategory(
                                      category: tokencontroll.category,
                                    )
                                    // data: categorycontroller.category,

                                    ),
                              ],
                            ),
                          ),
                        );
                      }),

                      //Single Slider
                      const SizedBox(
                        height: 0,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: GetBuilder<TokenController>(
                            builder: (bannercontrol) {
                          return bannercontrol.bannerprogrss
                              ? Container()
                              : InkWell(
                                  onTap: () async {
                                    var item =
                                        bannercontrol.banner.singlebanner![0];
                                    switch (item.check) {
                                      case 1:
                                        Get.toNamed(
                                            '/product/banner/${item.menu}',
                                            arguments: item.name);
                                        break;
                                      case 2:
                                        Get.toNamed(
                                            '/product/by/tag/${item.tag}',
                                            arguments: item.name);
                                        break;
                                      case 3:
                                        await launchUrl(
                                          Uri.parse(item.product.toString()),
                                          mode: LaunchMode.inAppWebView,

                                          // webViewConfiguration: const WebViewConfiguration(
                                          //     headers: <String, String>{
                                          //       'my_header_key': 'my_header_value'
                                          //     }),
                                        );
                                        break;
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: NetworkCatchImage(
                                        imagekey: bannercontrol
                                            .banner.singlebanner![0].image,
                                        image: Server.secondurl +
                                            '/' +
                                            bannercontrol
                                                .banner.singlebanner![0].src
                                                .toString(),
                                        height: 150),
                                  ),
                                );
                        }),
                      ),

                      //Product
                      const SizedBox(
                        height: 12,
                      ),

                      Container(
                        // height: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                  child: Text(
                                'Specialty Kitchen Tools',
                                style: detailText16,
                              )),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed('/product/new_arrival',
                                        arguments: 'Specialty Kitchen Tools');
                                  },
                                  child: Container(
                                      child: Text(
                                    'See All',
                                    style: smallText.copyWith(
                                      color: Theme.of(context).focusColor,
                                    ),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      GetBuilder<ProductController>(builder: (controller) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: SizedBox(
                              height: 240,
                              child: controller.newproducts != null
                                  ? HorizontalProductList(
                                      data: controller.newproducts,
                                    )
                                  : ShimmerProgress()),
                        );
                      }),

                      ///Small Bannel
                      const SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: GetBuilder<TokenController>(
                            builder: (bannercontrol) {
                          return bannercontrol.bannerprogrss
                              ? SizedBox(height: 70, child: ShimmerProgress())
                              : bannercontrol.banner.singlebanner!.isEmpty
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () async {
                                        var item = bannercontrol
                                            .banner.singlebanner![1];
                                        switch (item.check) {
                                          case 1:
                                            Get.toNamed(
                                                '/product/banner/${item.menu}',
                                                arguments: item.name);
                                            break;
                                          case 2:
                                            Get.toNamed(
                                                '/product/by/tag/${item.tag}',
                                                arguments: item.name);
                                            break;
                                          case 3:
                                            await launchUrl(
                                              Uri.parse(
                                                  item.product.toString()),
                                              mode: LaunchMode.inAppWebView,

                                              // webViewConfiguration: const WebViewConfiguration(
                                              //     headers: <String, String>{
                                              //       'my_header_key': 'my_header_value'
                                              //     }),
                                            );
                                            break;
                                        }
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: NetworkCatchImage(
                                          imagekey: bannercontrol
                                              .banner.singlebanner![1].image,
                                          image: Server.secondurl +
                                              '/' +
                                              bannercontrol
                                                  .banner.singlebanner![1].src
                                                  .toString(),
                                          height: 66,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                    );
                        }),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // Category Section
                      Container(
                        // height: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                  child: Text(
                                'One Time Packaging',
                                style: detailText16,
                              )),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed('/product/daily_need',
                                        arguments: 'One Time Packaging');
                                  },
                                  child: Container(
                                      child: Text(
                                    'See All',
                                    style: smallText.copyWith(
                                      color: Theme.of(context).focusColor,
                                    ),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      // SizedBox(
                      //     height: 230,
                      //     child: Horizontal3ProductList(
                      //         //data: pcontroller.dailyproducts.value,
                      //         )),

                      GetBuilder<ProductController>(builder: (controller) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 4.0, top: 5),
                          child: SizedBox(
                              height: 240,
                              child: controller.dailyproducts != null
                                  ? Horizontal3ProductList(
                                      data: controller.dailyproducts.value,
                                    )
                                  : ShimmerProgress()),
                        );
                      }),

                      const Divider(color: Colors.black12),

                      GetBuilder<TokenController>(builder: (bannercontrol) {
                        return bannercontrol.bannerprogrss
                            ? SizedBox(height: 150, child: ShimmerProgress())
                            : bannercontrol.banner.specialbanner!.isEmpty
                                ? Container()
                                : SizedBox(
                                    height: 140.0 *
                                        (bannercontrol
                                                .banner.specialbanner!.length ~/
                                            2),
                                    child: SpecialCategories(
                                      Categories:
                                          bannercontrol.banner.specialbanner,
                                      height: 140,
                                    ));
                      }),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 5, right: 5),
                        child: GetBuilder<TokenController>(
                            builder: (bannercontrol) {
                          return bannercontrol.bannerprogrss
                              ? SizedBox(height: 70, child: ShimmerProgress())
                              : bannercontrol.banner.singlebanner!.isEmpty
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () async {
                                        var item = bannercontrol
                                            .banner.singlebanner![2];
                                        switch (item.check) {
                                          case 1:
                                            Get.toNamed(
                                                '/product/banner/${item.menu}',
                                                arguments: item.name);
                                            break;
                                          case 2:
                                            Get.toNamed(
                                                '/product/by/tag/${item.tag}',
                                                arguments: item.name);
                                            break;
                                          case 3:
                                            print(item.product);

                                            await launchUrl(
                                              Uri.parse(
                                                  item.product.toString()),
                                              mode: LaunchMode.inAppWebView,

                                              // webViewConfiguration: const WebViewConfiguration(
                                              //     headers: <String, String>{
                                              //       'my_header_key': 'my_header_value'
                                              //     }),
                                            );
                                            break;
                                        }
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: NetworkCatchImage(
                                          imagekey: bannercontrol
                                              .banner.singlebanner![2].image,
                                          image: Server.secondurl +
                                              '/' +
                                              bannercontrol
                                                  .banner.singlebanner![2].src
                                                  .toString(),
                                          height: 66,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                    );
                        }),
                      ),

                      const Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Random Product',
                          style: detailText16,
                        ),
                      ),

                      GetBuilder<ProductController>(builder: (productcontrol) {
                        return Column(
                          children: [
                            SizedBox(
                                height: 331.0 /
                                        2 *
                                        productcontrol.mainproduct.length +
                                    40,
                                child: MainProductWidget(
                                  data: productcontrol.mainproduct,
                                )),
                            Visibility(
                              visible: productcontrol.progress,
                              //visible: true,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: CircularProgressIndicator(
                                      color: Theme.of(context).focusColor,
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Center(
                                        child: Text(
                                      'Loading ...',
                                      style: detailText18.copyWith(
                                          color: const Color.fromARGB(
                                              255, 13, 131, 228)),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                )
              ],
            ),
            // Positioned(
            //   top: 0,
            //   child: SizedBox(height: 75, child: SearchAppbar()),
            // ),
          ],
        ),
      ),
    );
  }
}
