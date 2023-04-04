import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/cartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartcontroller) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          leading: BackButton(
            onPressed: () {
              Get.offAllNamed('/homepage');
            },
          ),
          title: const Text('Thank You'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Congratulations! Your order has been successfully placed with Wonderfun. Thank you for choosing us.',
                style: detailText16,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                '#${cartcontroller.orderid}',
                style: headerText3,
              ),
              Text(
                'Date: ${DateTime.now()}',
                style: headerText3,
              ),
              // const Text(
              //   'Total:',
              //   style: headerText3,
              // ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'We are now processing your order and it will be shipped to you shortly. You will receive a separate email with shipping details and a tracking number once your order has been shipped.',
                style: detailText16,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'If you have any questions or concerns, please do not hesitate to contact us. We are here to assist you.',
                style: detailText16,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Thank you again for your order and we hope you enjoy your purchase from Wonderfun.',
                style: detailText16,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Best regards,',
                style: headerText2,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'dokanpat.com.bd,',
                style: headerText2,
              )
            ],
          ),
        )),
      );
    });
  }
}
