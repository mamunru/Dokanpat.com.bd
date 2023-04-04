import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dokanpat/configs/key_value.dart';
import 'package:dokanpat/configs/server.dart';
import 'package:dokanpat/configs/state.dart';
import 'package:dokanpat/configs/woocommerce_api.dart';
import 'package:dokanpat/model/cart_model.dart';
import 'package:dokanpat/model/payment_model.dart';
import 'package:dokanpat/model/product_model.dart';
import 'package:dokanpat/model/shipping_methods_model.dart';
import 'package:dokanpat/model/address_model.dart';
import 'package:dokanpat/services/woo_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../configs/themes/custome_text_style.dart';
import '../model/shoppingAddress_model.dart';

class CartController extends GetxController {
  final _box = GetStorage();
  var _cartlist = <cartModel>[].obs;
  var _selecteditems = <cartModel>[].obs;
  double total = 0;
  double final_total = 0;
  int pageindex = 0;
  int orderid = 0;
  String userid = '';
  int shopping_methodsindex = 0;
  String payment_url = '';
  bool paymentonloading = false;
  shoppingAddressModel shopping_address = shoppingAddressModel();

  RxList<cartModel> get cartlist => _cartlist;
  RxList<cartModel> get selecteditems => _selecteditems;

  var _shoppingmethods = <shoppingMethodModel>[].obs;
  RxList<shoppingMethodModel> get shoppingmethods => _shoppingmethods;

  var _payment = <PaymentModel>[].obs;
  RxList<PaymentModel> get payment => _payment;

  // ignore: prefer_final_fields
  var _addressList = <AddressModel>[].obs;
  RxList<AddressModel> get addressList => _addressList;
  //List<AddressModel> addressList = [];

  RxBool methodsisloading = false.obs;

  String first_name = '';
  String last_name = '';
  String phone = '';
  String email = '';
  String state = 'BD-00';
  String address = '';
  String statename = 'Select Your Location';

  List title = [
    {"title": "Address", "check": true},
    {"title": "Shipping", "check": false},
    {"title": "Preview", "check": false},
    {"title": "Pay Methods", "check": false}
  ];

  @override
  void onReady() {
    // getcartdata();
    readData();
    addressstore();
    super.onReady();
  }

  void addcart(
      int id,
      String name,
      String price,
      String regular_price,
      int quantiry,
      int? variation_id,
      String? variationValue,
      String? src,
      bool tagstatus) {
    int index = _cartlist.indexWhere((e) => e.product_id == id);
    //_selecteditems.addAll(_cartlist);
    int sindex = _selecteditems.indexWhere((e) => e.product_id == id);

    if (index < 0) {
      cartModel data = cartModel(
          product_id: id,
          name: name,
          price: price,
          quantity: quantiry,
          regularPrice: regular_price,
          variation_id: variation_id,
          variationValue: variationValue,
          src: src,
          check: true,
          tagstatus: tagstatus);
      _cartlist.add(data);
      _selecteditems.add(data);
    } else {
      if (_cartlist[index].variation_id == variation_id) {
        _cartlist[index].quantity = quantiry;
        _selecteditems[sindex].quantity = quantiry;
      } else {
        _cartlist[index].price = price;
        _cartlist[index].regularPrice = regular_price;
        _cartlist[index].quantity = quantiry;
        _cartlist[index].variationValue = variationValue;
        _cartlist[index].variation_id = variation_id;
        _cartlist[index].src = src;

        _selecteditems[sindex].price = price;
        _selecteditems[sindex].regularPrice = regular_price;
        _selecteditems[sindex].quantity = quantiry;
        _selecteditems[sindex].variation_id = variation_id;
        _selecteditems[sindex].variationValue = variationValue;
        _selecteditems[sindex].src = src;
      }
    }

    totalprice();
    storedata();

    update();
  }

  void directshopping(
      int id,
      String name,
      String price,
      String regular_price,
      int quantiry,
      int? variation_id,
      String? variationValue,
      String? src,
      bool? tagstatus) {
    int index = _cartlist.indexWhere((e) => e.product_id == id);
    cartModel data = cartModel(
        product_id: id,
        name: name,
        price: price,
        quantity: quantiry,
        regularPrice: regular_price,
        variation_id: variation_id,
        variationValue: variationValue,
        src: src,
        check: true,
        tagstatus: tagstatus);

    if (index < 0) {
      _cartlist.add(data);
      _selecteditems.add(data);
    } else {
      //_selecteditems.add(_cartlist[index]);
      if (_cartlist[index].variation_id == variation_id) {
        _cartlist[index].quantity = quantiry;
        _cartlist[index].check = true;
        int sindex = _selecteditems.indexWhere((e) => e.product_id == id);

        _selecteditems[sindex].quantity = quantiry;
        _selecteditems[sindex].check = true;
      } else {
        _cartlist[index].check = true;
        _cartlist[index].price = price;
        _cartlist[index].regularPrice = regular_price;
        _cartlist[index].quantity = quantiry;
        _cartlist[index].variationValue = variationValue;
        _cartlist[index].variation_id = variation_id;
        _cartlist[index].src = src;

        int sindex = _selecteditems.indexWhere((e) => e.product_id == id);

        _selecteditems[sindex].check = true;
        _selecteditems[sindex].price = price;
        _selecteditems[sindex].regularPrice = regular_price;
        _selecteditems[sindex].quantity = quantiry;
        _selecteditems[sindex].variationValue = variationValue;
        _selecteditems[sindex].variation_id = variation_id;
        _selecteditems[sindex].src = src;
      }
    }

    totalprice();

    update();
    Get.toNamed('/shopping/cart');
  }

  void storedata() async {
    // for (var i = 0; i < _cartlist.length; i++) {
    //   _cartlist[i].check = false;
    // }
    _box.write(ConstKey.cart_list, _cartlist);
  }

  void readlogindata() async {
    var cart_data = await _box.read(ConstKey.cart_list);
    userid = await _box.read(ConstKey.userid).toString();
    email = await _box.read(ConstKey.email).toString();
    state = await _box.read(ConstKey.stateid);
    statename = await _box.read(ConstKey.statename);

    update();
  }

  void readData() async {
    //_box.remove(ConstKey.cart_list);
    var cart_data = _box.read(ConstKey.cart_list);
    userid = _box.read(ConstKey.userid).toString();
    email = _box.read(ConstKey.email).toString();
    state = _box.read(ConstKey.stateid) == null
        ? 'BD-00'
        : _box.read(ConstKey.stateid);
    statename = _box.read(ConstKey.statename) == null
        ? 'Select Your Location'
        : _box.read(ConstKey.statename);

    if (email == "null" || userid == "null") {
      email = '';
      userid = '0';
    }
    // phone = _box.read(ConstKey.phone).toString();

    if (cart_data != null) {
      List<cartModel> finaldata =
          (cart_data as List).map((e) => cartModel.fromJson(e)).toList();

      _cartlist.value = finaldata;
      for (var i = 0; i < _cartlist.length; i++) {
        String url = '';

        if (_cartlist[i].variation_id! > 0) {
          url = Server.mainapi +
              woocommerce.products +
              "/${_cartlist[i].product_id}/variations/${_cartlist[i].variation_id}?consumer_key=${Server.consumer_key}&consumer_secret=${Server.secret_key}";
        } else {
          url = Server.mainapi +
              woocommerce.products +
              "/${_cartlist[i].product_id}?consumer_key=${Server.consumer_key}&consumer_secret=${Server.secret_key}";
        }

        var response = await Dio().get(url);

        _cartlist[i].price = response.data['price'];
        _cartlist[i].regularPrice = response.data['regular_price'];
      }
    }

    _selecteditems.addAll(_cartlist);
    totalprice();
    update();
  }

  void selecteditem(int id, int i) {
    int sindex = _selecteditems.indexWhere((e) => e.product_id == id);
    if (sindex < 0) {
      _selecteditems.add(_cartlist[i]);
    } else {
      _selecteditems.remove(_selecteditems[sindex]);
    }
    _cartlist[i].check = _cartlist[i].check! ? false : true;

    totalprice();
    update();
  }

  void addall() {
    if (_cartlist.length == _selecteditems.length) {
      _selecteditems.value = [];
      for (var i = 0; i < _cartlist.length; i++) {
        _cartlist[i].check = false;
      }
    } else {
      _selecteditems.value = [];
      _selecteditems.addAll(_cartlist);
      for (var i = 0; i < _cartlist.length; i++) {
        _cartlist[i].check = true;
      }
    }

    totalprice();
    update();
  }

  void addquantity(int index, int id) {
    _cartlist[index].quantity = _cartlist[index].quantity! + 1;
    if (_cartlist[index].check!) {
      int sindex = _selecteditems.indexWhere((e) => e.product_id == id);
      _selecteditems.remove(_selecteditems[sindex]);
      _selecteditems.add(_cartlist[index]);
      // _selecteditems[sindex].quantity = _selecteditems[sindex].quantity! + 1;
    }
    totalprice();
    update();
  }

  void addquantitywithnumber(int index, int id, int qty) {
    _cartlist[index].quantity = qty;
    if (_cartlist[index].check!) {
      int sindex = _selecteditems.indexWhere((e) => e.product_id == id);
      _selecteditems.remove(_selecteditems[sindex]);
      _selecteditems.add(_cartlist[index]);
      // _selecteditems[sindex].quantity = _selecteditems[sindex].quantity! + 1;
    }
    totalprice();
    update();
  }

  void minusquantity(int index, int id) {
    if (_cartlist[index].quantity! > 1) {
      _cartlist[index].quantity = _cartlist[index].quantity! - 1;
      if (_cartlist[index].check!) {
        int sindex = _selecteditems.indexWhere((e) => e.product_id == id);
        _selecteditems.remove(_selecteditems[sindex]);
        _selecteditems.add(_cartlist[index]);
      }
    }

    totalprice();
    update();
  }

  void removeitem(int index, int id) {
    if (_cartlist[index].check!) {
      int sindex = _selecteditems.indexWhere((e) => e.product_id == id);
      _selecteditems.remove(_selecteditems[sindex]);
    }
    _cartlist.remove(_cartlist[index]);

    totalprice();
    storedata();
    update();
  }

  void totalprice() {
    total = 0;
    if (_selecteditems.isNotEmpty) {
      _selecteditems.forEach((element) {
        total += double.parse(element.price.toString()) *
            double.parse(element.quantity.toString());
      });
    }

    if (shopping_methodsindex >= 0 && shoppingmethods.isNotEmpty) {
      double delivery = double.parse(shoppingmethods[shopping_methodsindex]
          .settings!
          .cost!
          .value
          .toString());

      final_total = total + delivery;
    }

    update();
  }

  void shippingZoon(
      String firstname,
      String lastname,
      String phonenumber,
      String inemail,
      String countryf,
      String statef,
      String address1,
      int index) async {
    methodsisloading.value = true;
    title[index]['check'] = true;
    if (pageindex < 3) {
      pageindex += 1;
    }

    first_name = firstname;
    last_name = lastname;
    phone = phonenumber;
    email = inemail;
    state = statef;
    address = address1;
    shopping_methodsindex = 0;
    update();

    // var data = await WooServices().callShippingZoons();
    // int id = (data as List).indexWhere((element) => element['name'] == state);
    if (statef == 'BD-12') {
      var shoppingmethod = await WooServices().callShippingMathods(1);
      List<shoppingMethodModel> methodslist = (shoppingmethod as List)
          .map((e) => shoppingMethodModel.fromJson(e))
          .toList();
      _shoppingmethods.value = methodslist;
      methodsisloading.value = false;
      double delivery = double.parse(shoppingmethods[shopping_methodsindex]
          .settings!
          .cost!
          .value
          .toString());
      final_total = total + delivery;
      update();
    } else {
      var shoppingmethod = await WooServices().callShippingMathods(2);
      List<shoppingMethodModel> methodslist = (shoppingmethod as List)
          .map((e) => shoppingMethodModel.fromJson(e))
          .toList();
      _shoppingmethods.value = methodslist;

      methodsisloading.value = false;

      double delivery = double.parse(shoppingmethods[shopping_methodsindex]
          .settings!
          .cost!
          .value
          .toString());
      final_total = total + delivery;
      update();
    }

    methodsisloading.value = false;

    update();
  }

  void storeSelectedMethods(int index) {
    shopping_methodsindex = index;
    double delivery =
        double.parse(shoppingmethods[index].settings!.cost!.value.toString());
    final_total = total + delivery;

    update();
  }

  void ChangepageIndex() {
    if (pageindex < 3) {
      pageindex += 1;
    }
    title[pageindex]['check'] = true;
    update();
  }

  void PaymentList() async {
    ///wp-json/wc/v3/payment_gateways
    _payment.clear();
    List<PaymentModel> listdata = await WooServices().PaymentGetway();
    listdata.forEach((element) {
      if (element.enabled!) {
        _payment.add(element);
      }
    });

    update();
  }

  void CreateOrder() async {
    paymentonloading = true;
    update();
    // Map<String, dynamic> order = <String, dynamic>{
    //   'payment_method_title': 'Online Payment',
    //   'payment_method': 'OP',
    //   'customer_id': 0,
    //   'billing': {
    //     'first_name': first_name,
    //     'last_name': last_name,
    //     'address_1': address,
    //     'address_2': "",
    //     'city': state,
    //     'country': "BD",
    //     'state': "BD",
    //     'postcode': '',
    //     'email': email,
    //     'phone': phone,
    //   },
    //   'shipping': {
    //     'first_name': first_name,
    //     'last_name': last_name,
    //     'address_1': address,
    //     'address_2': '',
    //     'city': state,
    //     'country': 'BD',
    //     'state': 'BD',
    //     'postcode': '',
    //     'email': email,
    //     'phone': phone,
    //   },
    //   'line_items': [
    //     for (int i = 0; i < selecteditems.length; i++)
    //       {
    //         'product_id': selecteditems[i].product_id,
    //         "quantity": selecteditems[i].quantity,
    //         // selecteditems[i].variation_id! > 0
    //         //     ? "variation_id"
    //         //     : selecteditems[i].variation_id: "",
    //       }
    //   ],
    //   'shipping_lines': [
    //     {
    //       'method_id': shoppingmethods[shopping_methodsindex].id,
    //       'method_title': shoppingmethods[shopping_methodsindex].title,
    //       'total': shoppingmethods[shopping_methodsindex].settings!.cost!.value
    //     }
    //   ],
    // };

    var data = await WooServices().createOrder(
        selecteditems: selecteditems,
        shoppingmethods: shoppingmethods[shopping_methodsindex],
        first_name: first_name,
        last_name: last_name,
        address: address,
        phone: phone,
        email: email,
        state: state,
        userid: userid.length > 0 ? int.parse(userid.toString()) : 0,
        payment_method_title: 'Online Payment',
        pay_menthod: 'OP',
        status: 'pending',
        set_paid: false);
    payment_url = data['payment_url'];
    orderid = data['id'];
    // payment_url =
    //     'https://dokanpat.com.bd/checkout/order-pay/46117/?pay_for_order=false&key=wc_order_kvDqO5AvSZ8cC';
    //print(order);
    //paymentonloading = false;
    // print(payment_url);
    title[2]['check'] = false;
    title[3]['check'] = false;
    clearCart();
    Get.offAndToNamed("/webview");
    paymentonloading = false;
    update();
  }

  void statechanege(String v,
      {String? fname, String? lname, String? ph, String? e}) {
    state = v;
    first_name = fname.toString();
    last_name = lname.toString();
    phone = ph.toString();
    email = e.toString();

    Bdstate.forEach((e) {
      if (e['id'] == v) {
        statename = e['name'];
        // print(e['name']);
      }
    });

    for (var i = 1; i < title.length; i++) {
      title[i]['check'] = false;
    }

    update();
  }

  void setlocaton(String name, String id) {
    state = id;

    statename = name;
    _box.write(ConstKey.stateid, id);
    _box.write(ConstKey.statename, name);

    if (id == 'BD-12' || id == 'BD-39') {
      _box.write(ConstKey.locationtag, 'home delelivery');
      // Get.toNamed('/');
    } else {
      _box.write(ConstKey.locationtag, '');
    }

    update();
  }

  void setlocatonandGoHome(String name, String id) {
    state = id;

    statename = name;

    //Get.offAllNamed('/homepage');

    update();
  }

  void updateOrder() async {
    int user = userid.length > 0 ? int.parse(userid.toString()) : 0;
    // print(user);

    if (user > 0) {
      var data = await WooServices().updateorder(user, orderid);
      if (data.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 2));
        Get.toNamed('/order/thank');
      }
    } else {
      await Future.delayed(const Duration(seconds: 2));
      Get.toNamed('/order/thank');
    }
  }

  void codorder() async {
    paymentonloading = true;
    update();
    // Map<String, dynamic> order = <String, dynamic>;

    var data = await WooServices().createOrder(
        selecteditems: selecteditems,
        shoppingmethods: shoppingmethods[shopping_methodsindex],
        first_name: first_name,
        last_name: last_name,
        address: address,
        phone: phone,
        email: email,
        state: state,
        userid: userid.length > 0 ? int.parse(userid.toString()) : 0,
        payment_method_title: 'Cash On Delivery',
        pay_menthod: 'cod',
        status: 'processing',
        set_paid: true);
    payment_url = data['payment_url'];
    orderid = data['id'];
    // payment_url =
    //     'https://dokanpat.com.bd/checkout/order-pay/46117/?pay_for_order=false&key=wc_order_kvDqO5AvSZ8cC';
    // print(order);
    clearCart();
    title[2]['check'] = false;
    title[3]['check'] = false;

    Get.toNamed("/order/thank");
    paymentonloading = false;
    update();
  }

  void clearCart() async {
    // var list = _cartlist;

    _selecteditems.forEach((value) {
      _cartlist.remove(value);

      // int sindex = _selecteditems.indexWhere((e) => e.id == value.id);
    });
    _box.remove(ConstKey.cart_list);
    _box.write(ConstKey.cart_list, _cartlist.value);
    _selecteditems.clear();
    totalprice();
    update();
  }

  void addressstore() {
    var data = _box.read(ConstKey.addresslist);
    if (data != null) {
      // print(data);
      List<AddressModel> finaldata =
          (data as List).map((e) => AddressModel.fromJson(e)).toList();
      _addressList.value = finaldata;

      finaldata.forEach((element) {
        if (element.check == true) {
          first_name = element.first_name.toString();
          last_name = element.last_name.toString();
          phone = element.phone.toString();
          address = element.address.toString();
          email = element.email.toString();
          state = element.state.toString();
          statename = element.statename.toString();
        }
      });
    }
    update();
  }

  void saveaddress(String fname, String lname, String inphone, String inaddress,
      String inemail) async {
    AddressModel f = AddressModel(
        first_name: fname,
        last_name: lname,
        phone: inphone,
        email: inemail,
        state: state,
        statename: statename,
        address: inaddress,
        check: true);

    var json = jsonEncode(f.toJson());

    int indexid = _addressList.value.indexWhere((element) =>
        element.state == state &&
        element.phone == inphone &&
        element.address == inaddress);
    // print('----------' + indexid.toString());
    if (indexid < 0) {
      for (var i = 0; i < _addressList.value.length; i++) {
        _addressList.value[i].check = false;
      }
      _addressList.add(AddressModel.fromJson(jsonDecode(json)));
      await _box.write(ConstKey.email, email);

      await _box.remove(ConstKey.addresslist);
      await _box.write(ConstKey.addresslist, addressList);
      Get.defaultDialog(
          title: "Your Address",
          middleText: "Your Address Save Successfully  ",
          backgroundColor: Colors.teal,
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white),
          radius: 30,
          actions: [
            Center(
              child: InkWell(
                onTap: () {
                  Get.back();

                  // Get.offAndToNamed('/login');
                  //Get.off(LoginPage());
                },
                child: Container(
                  width: 100,
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
      update();
    } else {
      Get.defaultDialog(
          title: "This Address Already Save",
          middleText: "Please Change Your address, phone or email. "
              "Then You  can save your address ",
          backgroundColor: Colors.redAccent,
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white),
          radius: 30,
          actions: [
            Center(
              child: InkWell(
                onTap: () {
                  Get.back();

                  // Get.offAndToNamed('/login');
                  //Get.off(LoginPage());
                },
                child: Container(
                  width: 100,
                  child: Center(
                    child: Text(
                      'OK',
                      style: detailText18.copyWith(
                          color: Color.fromARGB(255, 28, 3, 250)),
                    ),
                  ),
                ),
              ),
            )
          ]);
    }

    // _addressList.value = datalist;

    first_name = fname;
    last_name = lname;
    phone = inphone.toString();
    address = inaddress;
    email = inemail;

    update();
  }

  void changeshoppingaddress(int j) async {
    for (var i = 0; i < _addressList.value.length; i++) {
      AddressModel e = _addressList.value[i];
      if (i == j) {
        // print('====' + e.toString());
        e.check = true;
        first_name = e.first_name.toString();
        last_name = e.last_name.toString();
        phone = e.phone.toString();
        address = e.address.toString();
        email = e.email.toString();
        phone = e.phone.toString();
        state = e.state!;
        statename = e.statename!;

        update();
      } else {
        _addressList.value[i].check = false;
        update();
      }

      await _box.remove(ConstKey.addresslist);
      await _box.write(ConstKey.addresslist, _addressList);
      update();
    }
    // _addressList.value.forEach((key, e) {

    // });

    update();
  }

  void addresdelete(int i) {
    _addressList.value.remove(_addressList.value[i]);

    _box.remove(ConstKey.addresslist);
    _box.write(ConstKey.addresslist, _addressList.value);
    update();
  }
}
