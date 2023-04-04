import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/loginController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';

class SingUpPage extends StatelessWidget {
  SingUpPage({Key? key});

  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<loginController>(builder: (logincontroller) {
      return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sing up',
                    style: headerText2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade100))),
                                  child: TextFormField(
                                    controller: firstName,
                                    style: const TextStyle(fontSize: 18),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'First Name Not Empty';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "First Name",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade100))),
                                  child: TextFormField(
                                    controller: lastName,
                                    style: const TextStyle(fontSize: 18),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Last  Name Not Empty';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Lat Name",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade100))),
                                  child: TextFormField(
                                    controller: username,
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(fontSize: 18),
                                    validator: (value) {
                                      bool emailv = EmailValidator.validate(
                                          value.toString());
                                      if (value == null ||
                                          value.isEmpty ||
                                          emailv == false) {
                                        return 'Email or User Name is Empty or Invalide';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email or User Name",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade100))),
                                  child: TextFormField(
                                    controller: phone,
                                    keyboardType: TextInputType.phone,
                                    style: const TextStyle(fontSize: 18),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length != 11) {
                                        return 'Phone Not Empty';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Phone",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: password,
                                    obscureText: true,
                                    style: const TextStyle(fontSize: 18),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                        const SizedBox(
                          height: 30,
                        ),
                        logincontroller.singuploading
                            ? Container(
                                height: 50,
                                width: 50,
                                // decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(10),
                                //     gradient: const LinearGradient(colors: [
                                //       Color.fromRGBO(245, 5, 5, 1),
                                //       Color.fromRGBO(245, 1, 1, 1),
                                //     ])),
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).focusColor,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    // If the form is valid, display a Snackbar.\
                                    // FocusScope.of(context)
                                    //     .requestFocus(FocusNode());

                                    logincontroller.singup(
                                        fname: firstName.text,
                                        lname: lastName.text,
                                        email: username.text,
                                        phone: phone.text,
                                        password: password.text);
                                  }
                                  _formKey.currentState!.reset();
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(colors: [
                                        Color.fromRGBO(245, 5, 5, 1),
                                        Color.fromRGBO(245, 1, 1, 1),
                                      ])),
                                  child: const Center(
                                    child: Text(
                                      "Singup",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: const Text(
                                "If You have an Account",
                                style: TextStyle(
                                    color: Color.fromRGBO(7, 7, 7, 1)),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed('/login');
                                },
                                child: Text(
                                  'Login',
                                  style: detailText18,
                                ),
                              ),
                            )
                          ],
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
