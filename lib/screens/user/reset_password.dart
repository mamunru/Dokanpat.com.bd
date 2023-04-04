import 'package:dokanpat/controllers/loginController.dart';
import 'package:flutter/material.dart';

import '../../configs/themes/custome_text_style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

class PasswordReset extends StatelessWidget {
  PasswordReset({super.key});
  TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<loginController>(builder: (logincontroller) {
      return Material(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                child: const Text(
                  'PassWord Reset',
                  style: headerText2,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: const Text(
                  'Please Enter Your Email or User ID',
                  style: headerText3,
                ),
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
                    return 'Please Enter Valide Email ';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              logincontroller.passwordRest
                  ? Container(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).focusColor,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          print(email.text);
                          logincontroller.submitForgotPassword(email.text);
                          //Get.back();
                        }
                      },
                      child: Card(
                        child: Container(
                          height: 35,
                          width: 200,
                          color: Colors.red,
                          child: Center(
                              child: Text(
                            'Reset Password',
                            style: detailText16.copyWith(color: Colors.white),
                          )),
                        ),
                      ),
                    )
            ],
          ),
        ),
      );
    });
  }
}
