import 'package:dokanpat/controllers/mydrawer_controller.dart';
import 'package:dokanpat/screens/menu/menu_screen.dart';
import 'package:dokanpat/screens/products/product_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import '../../configs/themes/ui_parameter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LandingPage extends GetView<MyDrawerController> {
  LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MyDrawerController>(builder: (_) {
        return ZoomDrawer(
          borderRadius: 50.0,
          showShadow: true,
          angle: 0.0,
          style: DrawerStyle.DefaultStyle,
          controller: _.zoomDrawerController,
          backgroundColor: Colors.white.withOpacity(.5),
          slideWidth: MediaQuery.of(context).size.width * .49,
          menuScreen: MenuScreen(),
          mainScreen: ProductHomePage(),
          // mainScreen: SafeArea(
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     height: MediaQuery.of(context).size.height,
          //     color: Colors.white,
          //     child: Stack(
          //       //crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         //Custome AppBar
          //         Padding(
          //           padding: EdgeInsets.all(mobileScreenPadding),
          //           child: Container(
          //             height: 40,
          //             child: Row(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 AppCircleButton(
          //                     onTap: controller.toggleDrawer,
          //                     child: const FaIcon(
          //                       FontAwesomeIcons.bars,
          //                       //size: 25,
          //                       color: Colors.black,
          //                     )),
          //                 //  Expanded(child: Image(
          //                 //   height: 35,
          //                 //   width: MediaQuery.of(context).size.width*0.70,
          //                 //         image: AssetImage(
          //                 //             'assets/images/app-logo.png'))),
          //                 Padding(
          //                   padding: const EdgeInsets.only(right: 10),
          //                   child: Container(
          //                       child: FaIcon(
          //                     FontAwesomeIcons.magnifyingGlass,
          //                     size: 20,
          //                     color: Colors.black,
          //                   )),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),

          //         //Slow Product Sction

          //         Padding(
          //             padding: EdgeInsets.only(top: mobileScreenPadding + 40),
          //             child: ProductHomePage())
          //       ],
          //     ),
          //   ),
          // )
        );
      }),
    );
  }
}
