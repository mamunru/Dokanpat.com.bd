import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/cartController.dart';
import 'package:dokanpat/controllers/token_controller.dart';
import 'package:dokanpat/screens/home/category.dart';
import 'package:dokanpat/screens/home/landing.dart';
import 'package:dokanpat/screens/home/user.dart';
import 'package:dokanpat/screens/locationscreen.dart';
import 'package:dokanpat/services/local_notification.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../configs/key_value.dart';
import '../main.dart';
import 'home/cart_screen.dart';
import 'home/message_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'products/product_home_page.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String? _token;
  String? initialMessage;
  bool _resolved = false;
  static FirebaseInAppMessaging fiam = FirebaseInAppMessaging.instance;
  final box = GetStorage();
  bool isFirstLaunch = false;

  // ignore: prefer_final_fields
  List _widgetOptions = [
    ProductHomePage(),
    const MessageScreen(),
    CartScreen(),
    UserScreen()
  ];

  @override
  void initState() {
    token();
    LocalNotificationService.init();
    listentNotification();
    listentNotificationf();

    setState(() {
      isFirstLaunch = box.read(ConstKey.isFirstLaunch) ?? true;
    });

    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void token() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    TokenController tokencontroller = Get.find();
    tokencontroller.storetoken(fcmToken.toString());

    print('token = ' + fcmToken.toString());
  }

  void listentNotification() => LocalNotificationService.onNotifications.stream
      .listen(onclickNotification);

  void listentNotificationf() =>
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('----------------${message.messageId}----------');
        // TokenController tokenController = Get.find();
        // tokenController.onNotificationFunction();
        setState(() {
          _selectedIndex = 1;
        });

        //Get.toNamed('/homepage');
      });

  void onclickNotification(String? payload) {
    print('----------------$payload----------');
    TokenController tokenController = Get.find();
    tokenController.getnotification();

    //Get.toNamed('/homepage');
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isFirstLaunch
        ? LocationSCreen(
            ontap: () {
              setState(() {
                isFirstLaunch = false;
              });
            },
          )
        : Scaffold(
            //body: _widgetOptions[_selectedIndex],
            body: WillPopScope(
              onWillPop: () async {
                // Show exit dialog
                return await Get.dialog(
                  AlertDialog(
                    title: const Center(
                      child: Text(
                        'Confirm',
                        style: headerText3,
                      ),
                    ),
                    content: const Text(
                      'Are you sure you want to exit?',
                      style: detailText16,
                    ),
                    actions: [
                      TextButton(
                        child: const Text(
                          'Cancel',
                          style: detailText16,
                        ),
                        onPressed: () => Get.back(result: false),
                      ),
                      TextButton(
                        child: const Text(
                          'Exit',
                          style: detailText16,
                        ),
                        onPressed: () {
                          Get.back(result: true);
                        },
                      ),
                    ],
                  ),
                );
              },
              child: _widgetOptions[_selectedIndex],
            ),
            bottomNavigationBar:
                GetBuilder<CartController>(builder: (cartcontroller) {
              return Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Row(
                  // backgroundColor: Colors.white,

                  // showSelectedLabels: false,
                  // showUnselectedLabels: false,
                  // unselectedItemColor: Colors.black,
                  // //backgroundColor: Colors.red,
                  // //backgroundColor: Colors.white,
                  // //elevation: 1.0,
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 0;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: 50,
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.house,
                                size: _selectedIndex == 0 ? 28 : 22,
                                color: _selectedIndex == 0
                                    ? Theme.of(context).focusColor
                                    : Colors.black,
                              ),
                            ),
                          )),
                    ),
                    Expanded(
                      child: GetBuilder<TokenController>(
                          builder: (tokenController) {
                        return InkWell(
                            onTap: () {
                              // = Get.find();
                              tokenController.getnotification();
                              setState(() {
                                _selectedIndex = 1;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              height: 50,
                              child: Stack(
                                children: [
                                  Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.solidMessage,
                                      size: _selectedIndex == 1 ? 28 : 22,
                                      color: _selectedIndex == 1
                                          ? Theme.of(context).focusColor
                                          : Colors.black,
                                    ),
                                  ),
                                  Positioned(
                                      top: 0,
                                      left: MediaQuery.of(context).size.width /
                                              8 -
                                          5,
                                      child: Visibility(
                                        visible: tokenController.onnotification,
                                        child: Center(
                                            child: FaIcon(
                                          FontAwesomeIcons.solidBell,
                                          color:
                                              Color.fromARGB(255, 250, 225, 2),
                                        )),
                                      ))
                                ],
                              ),
                            ));
                      }),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 2;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: 50,
                          child: Stack(
                            children: [
                              Center(
                                child: FaIcon(
                                  FontAwesomeIcons.cartShopping,
                                  size: _selectedIndex == 2 ? 28 : 22,
                                  color: _selectedIndex == 2
                                      ? Theme.of(context).focusColor
                                      : Colors.black,
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  left:
                                      MediaQuery.of(context).size.width / 8 - 5,
                                  child: Visibility(
                                    visible: _selectedIndex != 2 &&
                                        cartcontroller.cartlist.length > 0,
                                    child: Center(
                                        child: Text(
                                      cartcontroller.cartlist.length.toString(),
                                      textAlign: TextAlign.center,
                                      style: detailText14.copyWith(
                                          color: Colors.red),
                                    )),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 3;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: 50,
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.solidUser,
                                size: _selectedIndex == 3 ? 28 : 22,
                                color: _selectedIndex == 3
                                    ? Theme.of(context).focusColor
                                    : Colors.black,
                              ),
                            ),
                          )),
                    )
                  ],
                  // currentIndex: _selectedIndex,
                  // selectedItemColor: Theme.of(context).focusColor,
                  // onTap: _onItemTapped,
                ),
              );
            }),
          );
  }
}
