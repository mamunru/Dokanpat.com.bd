import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rive/rive.dart';
import 'package:get/get.dart';

class NoInpernet extends StatelessWidget {
  NoInpernet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homecontroller) {
      return Scaffold(
        appBar: AppBar(
          title: Text('No Internet'),
          centerTitle: true,
        ),
        body: Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: RiveAnimation.asset(
                    fit: BoxFit.fitHeight,
                    'assets/images/rocket.riv',
                  ),
                ),
              ),
              Positioned(
                  bottom: MediaQuery.of(context).size.height * .15,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Please Connect Your Wifi Or Mobile Internet ",
                            style: headerText3.copyWith(
                                color: Color.fromARGB(255, 243, 25, 9)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        homecontroller.onloading
                            ? Center(
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context).focusColor,
                                    )),
                              )
                            : InkWell(
                                onTap: () {
                                  homecontroller.onInit();
                                },
                                child: Card(
                                  shape: CircleBorder(),
                                  child: Container(
                                    width: 200,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        'Try Again'.toUpperCase(),
                                        style: detailText16.copyWith(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      );
    });
  }
}
