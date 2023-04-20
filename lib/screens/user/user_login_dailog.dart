import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/loginController.dart';
import 'package:dokanpat/screens/user/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../../animation/fadeAnimation.dart';
import 'package:get/get.dart';

class UserLoginDailog extends StatelessWidget {
  UserLoginDailog({super.key});

  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<loginController>(builder: (logincontroller) {
      return Scaffold(
        // appBar: AppBar(
        //   iconTheme: const IconThemeData(color: Colors.black, size: 20),
        // ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/backgroundr.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      const Positioned(top: 20, child: BackButton()),
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(1,
                            child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(1.3,
                            child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(1.5,
                            child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(1.6,
                            child: Container(
                              margin: const EdgeInsets.only(top: 50),
                              child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(1.8,
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
                                  Visibility(
                                      visible: logincontroller.showerror,
                                      child: Text(
                                        'Email Or Password Wrong !!',
                                        style: detailText16.copyWith(
                                            color: Colors.red),
                                      )),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade100))),
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: username,
                                      style: const TextStyle(fontSize: 18),
                                      validator: (value) {
                                        bool emailv = EmailValidator.validate(
                                            value.toString());
                                        if (value == null ||
                                            value.isEmpty ||
                                            emailv == false) {
                                          return 'Email  is Empty or Invalide';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
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
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      logincontroller.trylogin
                          ? Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(colors: [
                                    Color.fromRGBO(245, 5, 5, 1),
                                    Color.fromRGBO(245, 1, 1, 1),
                                  ])),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, display a Snackbar.\
                                  // FocusScope.of(context)
                                  //     .requestFocus(FocusNode());

                                  logincontroller.checkoutlogin(
                                      username.text, password.text);
                                }
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
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 45,
                        child: Row(
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                Get.toNamed('/singup');
                              },
                              child: Card(
                                child: Container(
                                  height: 40,
                                  child: Center(
                                      child: Text(
                                    'Sing Up',
                                    style:
                                        headerText3.copyWith(color: Colors.red),
                                  )),
                                ),
                              ),
                            )),
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                Get.offAndToNamed('/checkout');
                              },
                              child: Card(
                                child: Container(
                                  height: 40,
                                  child: Center(
                                      child: Text(
                                    'Guest',
                                    style:
                                        headerText3.copyWith(color: Colors.red),
                                  )),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(1.5,
                          child: const Text(
                            "Continue You Shopping With Guest",
                            style:
                                TextStyle(color: Color.fromRGBO(4, 61, 248, 1)),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(1.5,
                          child: InkWell(
                            onTap: () {
                              Get.bottomSheet(Container(
                                color: Colors.white,
                                height:
                                    MediaQuery.of(context).size.height * .45,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: PasswordReset()),
                              ));
                            },
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * .80,
                              child: const Center(
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(250, 6, 6, 1)),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
