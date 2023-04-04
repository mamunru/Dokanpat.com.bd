import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/cartController.dart';
import 'package:dokanpat/screens/checkout/address_page.dart';
import 'package:dokanpat/screens/checkout/payment.dart';
import 'package:dokanpat/screens/checkout/preview_page.dart';
import 'package:dokanpat/screens/checkout/shipping_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  int pageindex = 0;
  List page = [
    AddressPage(),
    ShippingPage(),
    PreviewPage(),
    Payment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle(
        //   // Status bar color
        //   statusBarColor: Theme.of(context).focusColor,

        //   // Status bar brightness (optional)
        //   statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
        // ),
        iconTheme: const IconThemeData(color: Colors.black, size: 20),
        centerTitle: true,
        title: const Text(
          'CheckOut Page',
        ),
      ),
      body: GetBuilder<CartController>(builder: (controller) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                //height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: controller.title.asMap().entries.map((e) {
                    return Expanded(
                        child: GestureDetector(
                      onTap: () {
                        if (e.value['check']) {
                          setState(() {
                            controller.pageindex = e.key;
                          });
                        }
                      },
                      child: Center(
                          child: Text(
                        e.value['title'],
                        style: detailText16,
                        textAlign: TextAlign.center,
                      )),
                    ));
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  height: 2,
                  child: LinearProgressIndicator(
                    color: Colors.red,
                    value: (controller.pageindex + 1) / 4,
                  )),
              Expanded(
                child: Container(
                  // height: MediaQuery.of(context).size.height - 150,
                  child: page[controller.pageindex],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
