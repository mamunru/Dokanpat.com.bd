import 'package:dokanpat/configs/state.dart';
import 'package:dokanpat/controllers/cartController.dart';
import 'package:dokanpat/model/address_model.dart';
import 'package:flutter/material.dart';

import '../../configs/themes/custome_text_style.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:email_validator/email_validator.dart';

class AddressPage extends StatefulWidget {
  AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();

  ///Define Controller
  TextEditingController country = TextEditingController(text: 'Bangladesh');

  TextEditingController state = TextEditingController();

  TextEditingController address = TextEditingController();

  String countryValue = 'BD';

  String stateValue = '';

  String cityValue = '';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return GetBuilder<CartController>(builder: (controller) {
      first_name = TextEditingController(text: controller.first_name);
      last_name = TextEditingController(text: controller.last_name);
      phone = TextEditingController(text: controller.phone);
      email = TextEditingController(text: controller.email);
      address = TextEditingController(text: controller.address);

      stateValue = controller.state;
      bool notchangeState = false;
      bool statenot = false;
      controller.selecteditems.forEach(
        (element) {
          if (element.tagstatus!) {
            notchangeState = true;
          } else {
            statenot = false;
          }
        },
      );

      return Scaffold(
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: first_name,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name ',
                      labelText: 'First Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter First Name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: last_name,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Last name',
                      labelText: 'Last Name',
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phone,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Phone Number',
                      labelText: 'Phone Number',
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length != 11) {
                        return 'Please enter Phone (without +88)  ';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Email',
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      bool emailv = EmailValidator.validate(value.toString());
                      if (value == null || value.isEmpty || emailv == false) {
                        return 'Please enter Email ';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.none,
                    controller: country,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Country',
                      labelText: 'Country',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Country ';
                      }
                      return null;
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'District ',
                      style: detailText16,
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: notchangeState
                        ? DropdownButton2(
                            hint: Text(
                              'Select District ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: {
                              const DropdownMenuItem<String>(
                                value: 'BD-12',
                                child: Text(
                                  'Chuadanga',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const DropdownMenuItem<String>(
                                value: "BD-39",
                                child: Text(
                                  'Meherpur',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            }.toList(),
                            value: stateValue,
                            onChanged: (value) {
                              controller.statechanege(value.toString(),
                                  fname: first_name.text,
                                  lname: last_name.text,
                                  ph: phone.text,
                                  e: email.text);
                            },
                            buttonHeight: 55,
                            buttonWidth: MediaQuery.of(context).size.width,
                            itemHeight: 55,
                          )
                        : DropdownButton2(
                            hint: Text(
                              'Select District ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items:
                                Bdstate.map((item) => DropdownMenuItem<String>(
                                      value: item['id'],
                                      child: Text(
                                        item['name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    )).toList(),
                            value: stateValue,
                            onChanged: (value) {
                              controller.statechanege(value.toString(),
                                  fname: first_name.text,
                                  lname: last_name.text,
                                  ph: phone.text,
                                  e: email.text);
                            },
                            buttonHeight: 55,
                            buttonWidth: MediaQuery.of(context).size.width,
                            itemHeight: 55,
                          ),
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 1,
                  ),
                  TextFormField(
                    // maxLines: 10,
                    // keyboardType: TextInputType,
                    maxLines: 3,
                    controller: address,

                    decoration: const InputDecoration(
                      //focusColor: Colors.red,
                      hintText: 'House no/Building/post code',
                      labelText: 'Address',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            //  print(controller.addressList.value.length);
                            Get.bottomSheet(GetBuilder<CartController>(
                                builder: (ccontroller) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .65,
                                color: Colors.white,
                                child: ccontroller.addressList.value.isEmpty
                                    ? Container(
                                        child: const Center(
                                          child: Text(
                                            'No Address Save!! Please Save Your Address',
                                            style: detailText16,
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        itemCount: ccontroller
                                            .addressList.value.length,
                                        itemBuilder: (_, index) {
                                          AddressModel data = ccontroller
                                              .addressList.value[index];
                                          return notchangeState
                                              ? Visibility(
                                                  visible: notchangeState &&
                                                              data.state ==
                                                                  "BD-12" ||
                                                          data.state == "BD-39"
                                                      ? true
                                                      : false,
                                                  child: Card(
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              ccontroller
                                                                  .changeshoppingaddress(
                                                                      index);
                                                              Get.back();
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10,
                                                                      left: 20),
                                                              child: data.check ==
                                                                      true
                                                                  ? const FaIcon(
                                                                      FontAwesomeIcons
                                                                          .solidCircleCheck,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .red,
                                                                    )
                                                                  : const FaIcon(
                                                                      FontAwesomeIcons
                                                                          .circle,
                                                                      size: 20,
                                                                    ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                // print(index);
                                                                ccontroller
                                                                    .changeshoppingaddress(
                                                                        index);
                                                                Get.back();
                                                              },
                                                              child: Container(
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      'Name = ${data.first_name} ${data.last_name}',
                                                                      style:
                                                                          detailText15,
                                                                    ),
                                                                    Text(
                                                                      'phone = ${data.phone}',
                                                                      style:
                                                                          detailText15,
                                                                    ),
                                                                    Text(
                                                                      'email = ${data.email}',
                                                                      style:
                                                                          detailText15,
                                                                    ),
                                                                    Text(
                                                                      'city = ${data.statename}',
                                                                      style:
                                                                          detailText15,
                                                                    ),
                                                                    Text(
                                                                      'address = ${data.address}',
                                                                      style:
                                                                          detailText15,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: InkWell(
                                                              onTap: () {
                                                                ccontroller
                                                                    .addresdelete(
                                                                        index);
                                                              },
                                                              child:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .trash,
                                                                  size: 20,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Card(
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            ccontroller
                                                                .changeshoppingaddress(
                                                                    index);
                                                            Get.back();
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10,
                                                                    left: 20),
                                                            child: data.check ==
                                                                    true
                                                                ? const FaIcon(
                                                                    FontAwesomeIcons
                                                                        .solidCircleCheck,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .red,
                                                                  )
                                                                : const FaIcon(
                                                                    FontAwesomeIcons
                                                                        .circle,
                                                                    size: 20,
                                                                  ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: InkWell(
                                                            onTap: () {
                                                              // print(index);
                                                              ccontroller
                                                                  .changeshoppingaddress(
                                                                      index);
                                                              Get.back();
                                                            },
                                                            child: Container(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    'Name = ${data.first_name} ${data.last_name}',
                                                                    style:
                                                                        detailText15,
                                                                  ),
                                                                  Text(
                                                                    'phone = ${data.phone}',
                                                                    style:
                                                                        detailText15,
                                                                  ),
                                                                  Text(
                                                                    'email = ${data.email}',
                                                                    style:
                                                                        detailText15,
                                                                  ),
                                                                  Text(
                                                                    'city = ${data.statename}',
                                                                    style:
                                                                        detailText15,
                                                                  ),
                                                                  Text(
                                                                    'address = ${data.address}',
                                                                    style:
                                                                        detailText15,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: InkWell(
                                                            onTap: () {
                                                              ccontroller
                                                                  .addresdelete(
                                                                      index);
                                                            },
                                                            child:
                                                                const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .trash,
                                                                size: 20,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                        }),
                              );
                            }));
                          },
                          child: Card(
                            elevation: 1,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              height: 35,
                              child: Center(
                                  child: Text(
                                'Previes Address',
                                style: detailText16.copyWith(
                                    color:
                                        const Color.fromARGB(255, 7, 11, 247)),
                              )),
                            ),
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            if (controller.state != 'BD-00') {
                              if (_formKey.currentState!.validate()) {
                                controller.saveaddress(
                                    first_name.text,
                                    last_name.text,
                                    phone.text,
                                    address.text,
                                    email.text);
                              }
                            } else {
                              Get.defaultDialog(
                                  title: "No Location is Seleted !!",
                                  middleText: "Please Select Your Lacation",
                                  backgroundColor: Theme.of(context).focusColor,
                                  titleStyle: TextStyle(color: Colors.white),
                                  middleTextStyle:
                                      TextStyle(color: Colors.white),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          'OK',
                                          style: detailText16.copyWith(
                                              color: Colors.white),
                                        ))
                                  ]);
                            }
                          },
                          child: Card(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              height: 35,
                              // decoration: const BoxDecoration(
                              //     color: Color.fromARGB(255, 11, 52, 236)
                              //     ),
                              child: Center(
                                  child: Text(
                                'Save',
                                style: detailText16.copyWith(
                                    color: Color.fromARGB(255, 248, 9, 9)),
                              )),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              )),
        )),
        bottomNavigationBar: InkWell(
          onTap: () {
            // print(country.text);
            //FocusScope.of(context).unfocus();
            if (controller.state != 'BD-00') {
              if (_formKey.currentState!.validate()) {
                controller.shippingZoon(
                    first_name.text,
                    last_name.text,
                    phone.text,
                    email.text,
                    country.text,
                    stateValue,
                    address.text,
                    1);
              }
            } else {
              Get.defaultDialog(
                  title: "No Location is Seleted !!",
                  middleText: "Please Select Your Lacation",
                  backgroundColor: Theme.of(context).focusColor,
                  titleStyle: TextStyle(color: Colors.white),
                  middleTextStyle: TextStyle(color: Colors.white),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'OK',
                          style: detailText16.copyWith(color: Colors.white),
                        ))
                  ]);
            }
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
