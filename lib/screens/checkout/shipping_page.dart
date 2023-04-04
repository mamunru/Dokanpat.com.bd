import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/cartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShippingPage extends StatelessWidget {
  const ShippingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return Scaffold(
        body: controller.methodsisloading.value
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: CircularProgressIndicator(
                  color: Theme.of(context).focusColor,
                )),
              )
            : SingleChildScrollView(
                child: Column(
                children: controller.shoppingmethods.map((element) {
                  int index = controller.shoppingmethods.indexOf(element);
                  return InkWell(
                    onTap: () {
                      controller.storeSelectedMethods(index);
                    },
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: controller.shopping_methodsindex == index
                                ? const FaIcon(
                                    FontAwesomeIcons.solidCircleCheck,
                                    size: 20,
                                    color: Colors.red,
                                  )
                                : const FaIcon(
                                    FontAwesomeIcons.circle,
                                    size: 20,
                                  ),
                          ),
                          title: Text(
                            element.title.toString(),
                            style: detailText18,
                          ),
                          subtitle: Text(
                            // ignore: prefer_interpolation_to_compose_strings
                            'Delivery ' +
                                element.settings!.cost!.value.toString() +
                                ' TK',
                            style: detailText15,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )),
        bottomNavigationBar: InkWell(
          onTap: () {
            controller.ChangepageIndex();

            // if (_formKey.currentState!.validate()) {
            //   // If the form is valid, display a Snackbar.\
            //   print(firstname.text);
            // }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 5),
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).focusColor,
              //borderRadius: BorderRadius.circular(50)
            ),
            child: Center(
              child: Text(
                'Continue'.toString().toUpperCase(),
                style: headerText3.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      );
    });
  }
}
