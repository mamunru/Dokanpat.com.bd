import 'package:dokanpat/configs/key_value.dart';
import 'package:dokanpat/configs/server.dart';
import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/loginController.dart';
import 'package:dokanpat/widgets/gender_button.dart';
import 'package:dokanpat/widgets/images/network_images.dart';
import 'package:dokanpat/widgets/profile_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../configs/themes/ui_parameter.dart';
import '../../controllers/mydrawer_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../widgets/app_circle_button.dart';
import '../menu/menu_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class UserScreen extends GetView<MyDrawerController> {
  UserScreen({super.key});
  bool isSwitched = false;
  var textValue = 'Switch is OFF';
  final GlobalKey _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuScreen(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          //height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Custome AppBar
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          Server.secondurl + '/public/banner/setting.jpg',
                        ),
                        fit: BoxFit.cover)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 10),
                      child: Builder(builder: (context) {
                        return AppCircleButton(
                            onTap: () {
                              //print('ok');
                              Scaffold.of(context).openDrawer();
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.bars,
                              size: 30,
                              color: Colors.white,
                            ));
                      }),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 130, left: 20),
                        child: Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width * 0.70,
                            child: Text(
                              'Settings',
                              style: headerText.copyWith(
                                  fontSize: 30, color: Colors.white),
                            ))),
                  ],
                ),
              ),

              //Profile Setttings

              GetBuilder<loginController>(builder: (logincontroller) {
                return logincontroller.wootoken!.isNotEmpty
                    ? Container(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InkWell(
                            onTap: () {
                              //print(logincontroller.wootoken);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(logincontroller
                                              .image
                                              .toString()))),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 10),
                                    child: Text(
                                      logincontroller.username!,
                                      style: headerText3,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed('/login');
                          },
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: FaIcon(
                                  FontAwesomeIcons.solidUser,
                                  size: 20,
                                ),
                              ),
                              Expanded(
                                  child: Text('Login', style: profileTitle)),
                              FaIcon(
                                FontAwesomeIcons.angleRight,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      );
              }),

              Container(
                padding: const EdgeInsets.all(15),
                child: const Text(
                  "General Setting",
                  style: headerText3,
                ),
              ),

              GetBuilder<loginController>(builder: (logincontroller) {
                return Visibility(
                  visible: logincontroller.wootoken!.isNotEmpty ? true : false,
                  child: Column(
                    children: [
                      ProfileTitle(
                          tittle: 'My Order',
                          icon: const FaIcon(
                            FontAwesomeIcons.shop,
                            size: 20,
                          ),
                          onTap: () {
                            Get.toNamed('/order/history');
                          }),
                      const Padding(
                        padding: EdgeInsets.only(left: 60, right: 10),
                        child: Divider(
                          thickness: 1.2,
                        ),
                      ),
                    ],
                  ),
                );
              }),

              Padding(
                padding: EdgeInsets.only(left: 20, right: 10),
                child: Container(height: 50, child: GenderButton()),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 60, right: 10),
                child: Divider(
                  thickness: 1.2,
                ),
              ),

              ProfileTitle(
                  tittle: 'WishList',
                  icon: const FaIcon(
                    FontAwesomeIcons.heart,
                    size: 20,
                  ),
                  onTap: () {
                    Get.toNamed('/wishlist');
                  }),

              ProfileTitle(
                  tittle: 'Rate App',
                  icon: const FaIcon(
                    FontAwesomeIcons.star,
                    size: 20,
                  ),
                  onTap: () async {
                    await launchUrl(
                        Uri.parse(
                            'https://play.google.com/store/apps/details?id=${Server.package}'),
                        mode: LaunchMode.externalApplication,
                        webViewConfiguration: WebViewConfiguration(
                          headers: <String, String>{
                            'header_key': 'header_value'
                          },
                        ));
                  }),

              const Padding(
                padding: EdgeInsets.only(left: 60, right: 10),
                child: Divider(
                  thickness: 1.2,
                ),
              ),
              ProfileTitle(
                  tittle: 'Privacy and Term',
                  icon: const FaIcon(
                    FontAwesomeIcons.file,
                    size: 20,
                  ),
                  onTap: () {
                    Get.toNamed('/privacy');
                  }),
              const Padding(
                padding: EdgeInsets.only(left: 60, right: 10),
                child: Divider(
                  thickness: 1.2,
                ),
              ),

              ProfileTitle(
                  tittle: 'About Us',
                  icon: const FaIcon(
                    FontAwesomeIcons.circleInfo,
                    size: 20,
                  ),
                  onTap: () {
                    Get.toNamed('/contactus');
                  }),
              const Padding(
                padding: EdgeInsets.only(left: 60, right: 10),
                child: Divider(
                  thickness: 1.2,
                ),
              ),

              GetBuilder<loginController>(builder: (logincontroller) {
                return Visibility(
                  visible: logincontroller.wootoken!.isNotEmpty ? true : false,
                  child: ProfileTitle(
                      tittle: 'Log Out',
                      icon: const FaIcon(
                        FontAwesomeIcons.powerOff,
                        size: 20,
                        color: Colors.red,
                      ),
                      onTap: () {
                        logincontroller.logout();
                      }),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
