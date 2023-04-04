import 'package:dio/dio.dart';
import 'package:dokanpat/configs/key_value.dart';
import 'package:dokanpat/configs/server.dart';
import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/cartController.dart';
import 'package:dokanpat/model/shoppingAddress_model.dart';
import 'package:dokanpat/screens/user/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart';
import 'package:get_storage/get_storage.dart';

class loginController extends GetxController {
  final _box = GetStorage();
  String? wootoken = '';
  bool showerror = false;
  bool trylogin = false;
  String? username = '';
  String? image = '';
  String? userid = '';
  bool singuploading = false;
  bool passwordRest = false;

  @override
  void onReady() {
    // trytologin();
    getdata();
    super.onReady();
  }

  void getdata() async {
    String? token = _box.read(ConstKey.wootoken);
    if (token.toString().length > 10) {
      wootoken = token;
      username = _box.read(ConstKey.username);
      image = _box.read(ConstKey.userimage);
      userid = _box.read(ConstKey.userid);
    }

    update();
  }

  void trytologin(String username, String password) async {
    var cookieLifeTime = 120960000000;
    showerror = false;
    trylogin = true;
    update();

    try {
      var response = await Dio().post(
          '${Server.mainurl}/wp-json/api/flutter_user/generate_auth_cookie/?insecure=cool',
          data: convert.jsonEncode({
            'seconds': cookieLifeTime.toString(),
            'username': username,
            'password': password
          }),
          options: Options(headers: {'Content-Type': 'application/json'}));

      if (response.statusCode == 200) {
        // print(response.data.toString());
        var bytes = convert.utf8.encode(response.data['cookie']);
        var base64Str = convert.base64.encode(bytes);
        //var data = convert.jsonDecode(response.data);
        // print(response.data['user'].toString().toString());
        wootoken = base64Str;

        _box.write(ConstKey.wootoken, base64Str);
        _box.write(ConstKey.userid, response.data['user']['id'].toString());
        _box.write(
            ConstKey.username, response.data['user']['nicename'].toString());
        _box.write(ConstKey.email, response.data['user']['email'].toString());
        _box.write(
            ConstKey.fixemail, response.data['user']['email'].toString());
        _box.write(
            ConstKey.userimage, response.data['user']['avatar'].toString());
        // _box.write(ConstKey.shoppingAddress,
        //     response.data['user']['shipping'].toString());

        getdata();
        trylogin = false;
        CartController cartcontroller = Get.find();
        cartcontroller.readlogindata();
        update();

        Get.back();
      }
    } catch (e) {
      showerror = true;
      print(e);
      trylogin = false;
      update();
    }

    trylogin = false;
    update();

    //print(response);
  }

  void logout() {
    _box.remove(ConstKey.userid);
    //_box.remove(ConstKey.token);
    _box.remove(ConstKey.email);
    _box.remove(ConstKey.phone);
    _box.remove(ConstKey.username);

    _box.remove(ConstKey.fixemail);
    _box.remove(ConstKey.wootoken);
    _box.write(ConstKey.userid, "0");

    wootoken = '';
    username = '';
    image = '';
    userid = '';
    CartController cartcontroller = Get.find();
    cartcontroller.readlogindata();
    update();
  }

  void singup(
      {required String? fname,
      required String? lname,
      required String? email,
      required String? phone,
      required String? password}) async {
    singuploading = true;
    update();
    String niceName = fname.toString() + ' ' + lname.toString();
    var data = convert.jsonEncode({
      'user_email': email,
      'user_login': email,
      'username': email,
      'user_pass': password,
      'email': username,
      'user_nicename': niceName,
      'display_name': niceName,
      'phone': phone,
      'first_name': fname,
      'last_name': lname,
    });

    print(data);

    try {
      var response = await Dio().post(
          '${Server.mainurl}/wp-json/api/flutter_user/sign_up_2/?insecure=cool',
          data: data,
          options: Options(headers: {'Content-Type': 'application/json'}));

      if (response.statusCode == 200) {
        Get.back();
        Get.defaultDialog(
            title: "Thank You For Singup",
            middleText: "You account has Successfully Create  "
                "Now you can shopping easily "
                "Please Login",
            backgroundColor: Colors.teal,
            titleStyle: const TextStyle(color: Colors.white),
            middleTextStyle: const TextStyle(color: Colors.white),
            radius: 30,
            actions: [
              Container(
                child: InkWell(
                  onTap: () {
                    Get.back();

                    // Get.offAndToNamed('/login');
                    //Get.off(LoginPage());
                  },
                  child: Container(
                    height: 30,
                    width: 200,
                    child: Center(
                      child: Text(
                        'OK',
                        style: detailText18.copyWith(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              )
            ]);
      } else {
        Get.defaultDialog(
            title: "We Are Sorry !!",
            middleText: "You account has Not Crate Successfully "
                " Please Try Again",
            backgroundColor: const Color.fromARGB(255, 245, 4, 4),
            titleStyle: const TextStyle(color: Colors.white),
            middleTextStyle: const TextStyle(color: Colors.white),
            radius: 30);
      }

      // print(response.data);
    } catch (e) {
      print(e);
      Get.defaultDialog(
          title: "We Are Sorry !!",
          middleText: "You account has Not Crate Successfully "
              " Please Try Again",
          backgroundColor: const Color.fromARGB(255, 245, 4, 4),
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white),
          radius: 30);
    }

    singuploading = false;
    update();
  }

  void checkoutlogin(String username, String password) async {
    var cookieLifeTime = 120960000000;
    showerror = false;
    trylogin = true;
    update();

    try {
      var response = await Dio().post(
          '${Server.mainurl}/wp-json/api/flutter_user/generate_auth_cookie/?insecure=cool',
          data: convert.jsonEncode({
            'seconds': cookieLifeTime.toString(),
            'username': username,
            'password': password
          }),
          options: Options(headers: {'Content-Type': 'application/json'}));

      if (response.statusCode == 200) {
        print(response.data.toString());
        var bytes = convert.utf8.encode(response.data['cookie']);
        var base64Str = convert.base64.encode(bytes);
        //var data = convert.jsonDecode(response.data);
        // print(response.data['user'].toString().toString());
        wootoken = base64Str;

        _box.write(ConstKey.wootoken, base64Str);
        _box.write(ConstKey.userid, response.data['user']['id'].toString());
        _box.write(
            ConstKey.username, response.data['user']['nicename'].toString());
        _box.write(ConstKey.email, response.data['user']['email'].toString());
        _box.write(
            ConstKey.fixemail, response.data['user']['email'].toString());

        _box.write(
            ConstKey.userimage, response.data['user']['avatar'].toString());
        // _box.write(ConstKey.shoppingAddress,
        //     response.data['user']['shipping'].toString());

        getdata();
        trylogin = false;
        CartController cartcontroller = Get.find();
        cartcontroller.readlogindata();
        update();

        Get.toNamed('/checkout');
      }
    } catch (e) {
      showerror = true;
      trylogin = false;
      print(e);

      update();
    }

    trylogin = false;

    update();

    //print(response);
  }

  void submitForgotPassword(String useremailid) async {
    Map<String, dynamic> indata = {'user_login': useremailid};
    passwordRest = true;
    update();
    try {
      var response = await Dio().post(
          '${Server.mainurl}/wp-json/api/flutter_user/reset-password',
          data: convert.jsonEncode(indata),
          options: Options(headers: {'Content-Type': 'application/json'}));
      // var result = convert.jsonDecode(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.back();
        Get.defaultDialog(
            title: "Password Reset Request !!",
            middleText: "You Request has Successfully Create "
                " Please Check Your Mail",
            backgroundColor: Color.fromARGB(255, 4, 48, 245),
            titleStyle: const TextStyle(color: Colors.white),
            middleTextStyle: const TextStyle(color: Colors.white),
            radius: 30,
            actions: [
              Container(
                child: InkWell(
                  onTap: () {
                    Get.back();

                    // Get.offAndToNamed('/login');
                    //Get.off(LoginPage());
                  },
                  child: Container(
                    height: 30,
                    width: 200,
                    child: Center(
                      child: Text(
                        'OK',
                        style: detailText18.copyWith(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              )
            ]);
      } else {
        Get.defaultDialog(
            title: "Password Reset Faild !! ",
            middleText: "Please Check Your UserId or email "
                " And Try Again",
            backgroundColor: Color.fromRGBO(245, 209, 4, 1),
            titleStyle: const TextStyle(color: Colors.white),
            middleTextStyle: const TextStyle(color: Colors.white),
            radius: 30,
            actions: [
              Container(
                child: InkWell(
                  onTap: () {
                    Get.back();

                    // Get.offAndToNamed('/login');
                    //Get.off(LoginPage());
                  },
                  child: Container(
                    height: 30,
                    width: 200,
                    child: Center(
                      child: Text(
                        'OK',
                        style: detailText18.copyWith(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              )
            ]);
      }
    } catch (e) {
      Get.defaultDialog(
          title: "Password Reset Faild !!",
          middleText: "Please Check Your UserId or email "
              " And Try Again",
          backgroundColor: Color.fromRGBO(245, 209, 4, 1),
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white),
          radius: 30,
          actions: [
            Container(
              height: 30,
              child: InkWell(
                onTap: () {
                  Get.back();

                  // Get.offAndToNamed('/login');
                  //Get.off(LoginPage());
                },
                child: Container(
                  height: 30,
                  width: 200,
                  child: Center(
                    child: Text(
                      'OK',
                      style: detailText18.copyWith(color: Colors.red),
                    ),
                  ),
                ),
              ),
            )
          ]);
    }

    passwordRest = false;
    update();
  }
}
