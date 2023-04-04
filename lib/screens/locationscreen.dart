import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../configs/state.dart';
import '../controllers/cartController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';

class LocationSCreen extends StatefulWidget {
  VoidCallback ontap;
  LocationSCreen({required this.ontap, super.key});

  @override
  State<LocationSCreen> createState() => _LocationSCreenState();
}

class _LocationSCreenState extends State<LocationSCreen> {
  bool loading = false;
  bool active = false;
  final _box = GetStorage();

  @override
  Widget build(BuildContext context) {
    CartController cartcontroller = Get.find();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Slect Your Location'),
        centerTitle: true,
      ),
      body: loading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Flexible(
                      child: Text(
                        'By selecting your location, you can take advantage of location-based services and receive customized offers or information based on your area. This may include access to exclusive deals, nearby events, or recommendations tailored to your location',
                        style: detailText16.copyWith(),
                      ),
                    ),
                    // child: SvgPicture.asset(
                    //   'assets/images/map.svg',
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.height * .65,
                    // ),
                  ),

                  // Positioned(
                  //     top: 0,
                  //     left: 0,
                  //     child: BangladeshMap(
                  //       width: MediaQuery.of(context).size.width,
                  //       height: MediaQuery.of(context).size.height - 100,
                  //       rangpurColor: Colors.orange,
                  //       rajshahiColor: Colors.red,
                  //       dhakaColor: Colors.indigo,
                  //       sylhetColor: Colors.blue,
                  //       khulnaColor: Colors.teal,
                  //       chittagongColor: Colors.grey,
                  //       barisalColor: Colors.pink,
                  //       mymensinghColor: Colors.brown,
                  //       showBorder: true,
                  //       showName: true,
                  //       showDivisionBorder: true,
                  //       showDistrictBorder: true,
                  //     )
                  //     ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  Container(
                    child: Flexible(
                      child: Text(
                        'You can change it later.',
                        style: detailText16.copyWith(
                            color: Colors.red, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    // top: MediaQuery.of(context).size.height / 2.85,
                    // left: 20,
                    child:
                        GetBuilder<HomeController>(builder: (homecontroller) {
                      return InkWell(
                        onTap: () {
                          print('ok');
                          Get.bottomSheet(Container(
                            height: MediaQuery.of(context).size.height * .55,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                itemCount: Bdstate.length,
                                itemBuilder: (_, index) {
                                  return InkWell(
                                    onTap: () {
                                      // print(Bdstate[index]['name']);
                                      if (Bdstate[index]['id'] != 'BD-00') {
                                        homecontroller.storedata(
                                            name: Bdstate[index]['name'],
                                            id: Bdstate[index]['id']);
                                        setState(() {
                                          active = true;
                                        });
                                        Get.back();
                                      }

                                      // Get.offAllNamed('/homepage');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
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
                            width: MediaQuery.of(context).size.width,
                            //color: Colors.red,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: FaIcon(
                                    FontAwesomeIcons.locationPin,
                                    size: 16,
                                    color: Theme.of(context).focusColor,
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
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
                    }),
                  )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: active
            ? Theme.of(context).focusColor
            : Color.fromARGB(169, 85, 80, 80),
        onPressed: () {
          widget.ontap;
          //Get.back();
          if (active) {
            setState(() {
              loading = true;
            });

            Future.delayed(Duration(milliseconds: 500), widget.ontap);
            //Get.offAllNamed('/homepage');
          }
          // Future.delayed(Duration(milliseconds: 500), widget.ontap);
        },
        child: const FaIcon(FontAwesomeIcons.angleRight),
      ),
    );
  }
}
