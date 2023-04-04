import 'dart:convert';
import 'dart:io';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
//import 'package:dio/dio.dart' as diooption;
// import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:dokanpat/configs/server.dart';
import 'package:dokanpat/configs/woocommerce_api.dart';
import 'package:dokanpat/model/cart_model.dart';

import 'package:dokanpat/model/order_model.dart';
import 'package:dokanpat/model/payment_model.dart';
import 'package:dokanpat/model/product_model.dart';
import 'package:dokanpat/model/review_model.dart';
import 'package:dokanpat/screens/checkout/payment.dart';

import '../model/shipping_methods_model.dart';

class WooServices {
  Future<List<productModel>> getproducts(
      {int? pagenumber,
      int? pagesize,
      String? search,
      String? tag,
      int? category,
      String? sortBy,
      String sortOrder = "asc"}) async {
    String parameter = "";
    Response response;
    if (pagenumber != null) {
      parameter += "&page=$pagenumber";
    }

    if (search != null) {
      parameter += "&search=$search";
    }

    if (pagesize != null) {
      parameter += "&per_page=$pagesize";
    }

    if (category != null) {
      parameter += "&category=$category";
    }

    if (tag != null) {
      parameter += "&tag=$tag";
    }

    if (sortBy != null) {
      parameter += "&orderby=$sortBy";
    }

    if (sortOrder != null) {
      parameter += "&order=$sortOrder";
    }

    try {
      String url = Server.mainapi +
          woocommerce.products +
          "?consumer_key=${Server.consumer_key}&consumer_secret=${Server.secret_key}${parameter}";

      response = await Dio().get(url);
      var products = response.data;

      final items = (response.data as List)
          .map((data) => productModel.fromJson(data))
          .toList();

      return items;
    } on DioError catch (e) {
      print(e);
      throw "Error Coming From Products" + e.toString();
    }
  }

  Future<List<reviewModel>> ReviewApi(int id) async {
    Response response;
    String url = Server.mainapi +
        woocommerce.reviews +
        "?product=$id&consumer_key=${Server.consumer_key}&consumer_secret=${Server.secret_key}";

    try {
      response = await Dio().get(url);

      var products = response.data;

      final items = (response.data as List)
          .map((data) => reviewModel.fromJson(data))
          .toList();
      // print('--------------review----' + items.length.toString());

      return items;
    } on DioError catch (e) {
      print(e);
      throw "Error Coming From Review";
    }
  }

  Future<List> callShippingZoons() async {
    Response response;
    String url = Server.mainapi +
        woocommerce.zones +
        "?consumer_key=${Server.consumer_key}&consumer_secret=${Server.secret_key}";

    response = await Dio().get(url);
    //print(response.data);
    return response.data;
  }

  Future<List> callShippingMathods(int id) async {
    Response response;
    String url = Server.mainapi +
        woocommerce.zones +
        "/$id/methods" +
        "?consumer_key=${Server.consumer_key}&consumer_secret=${Server.secret_key}";

    response = await Dio().get(url);
    //print("data" + response.data.toString());
    return response.data;
  }

  Future<List<PaymentModel>> PaymentGetway() async {
    Response response;
    String url = Server.mainapi +
        woocommerce.payment_gateways +
        "?consumer_key=${Server.consumer_key}&consumer_secret=${Server.secret_key}";

    response = await Dio().get(url);
    final data =
        (response.data as List).map((e) => PaymentModel.fromJson(e)).toList();
    // print(response.data);
    return data;
  }

  //Order

  Future<List<OrderModel>> OrderHistory(String userid,
      {required int? page}) async {
    Response response;
    String url = Server.mainapi +
        woocommerce.orders +
        "?consumer_key=${Server.consumer_key}&consumer_secret=${Server.secret_key}&customer=$userid&page=$page&per_page=10";

    try {
      //print(url);
      response = await Dio().get(url);
      final data =
          (response.data as List).map((e) => OrderModel.fromJson(e)).toList();
      // print(response.data);
      return data;
    } on DioError catch (e) {
      print(e);
      throw "Error Coming From Review";
    }
  }

  Future<Map<String, dynamic>> createOrder(
      {required List<cartModel> selecteditems,
      required shoppingMethodModel shoppingmethods,
      required int userid,
      required String first_name,
      required String last_name,
      required String address,
      required String state,
      required String phone,
      required String email,
      required bool set_paid,
      required String status,
      required String payment_method_title,
      required String pay_menthod}) async {
    Response response;
    Dio dio = Dio();

    // print(convert.jsonEncode(selecteditems));
    Map<String, dynamic>? data;

    if (pay_menthod == 'cod') {
      Map<String, dynamic> data1 = {
        'payment_method_title': payment_method_title,
        'payment_method': pay_menthod,
        'set_paid': set_paid,
        'customer_id': userid,
        // 'set_paid': false,
        'billing': {
          'first_name': first_name,
          'last_name': last_name,
          'address_1': address,
          'address_2': "",
          'city': state,
          'country': "BD",
          'state': state,
          'postcode': '',
          'email': email,
          'phone': phone,
        },
        'shipping': {
          'first_name': first_name,
          'last_name': last_name,
          'address_1': address,
          'address_2': '',
          'city': state,
          'country': 'BD',
          'state': state,
          'postcode': '',
          'email': email,
          'phone': phone,
        },
        'line_items': selecteditems,
        "status": status,

        'shipping_lines': [
          {
            'method_id': shoppingmethods.id,
            'method_title': shoppingmethods.title,
            'total': shoppingmethods.settings!.cost!.value
          }
        ],
      };

      data = data1;
    } else {
      Map<String, dynamic> data1 = {
        'payment_method_title': payment_method_title,
        'payment_method': pay_menthod,
        'set_paid': set_paid,
        //'customer_id': userid,
        // 'set_paid': false,
        'billing': {
          'first_name': first_name,
          'last_name': last_name,
          'address_1': address,
          'address_2': "",
          'city': state,
          'country': "BD",
          'state': state,
          'postcode': '',
          'email': email,
          'phone': phone,
        },
        'shipping': {
          'first_name': first_name,
          'last_name': last_name,
          'address_1': address,
          'address_2': '',
          'city': state,
          'country': 'BD',
          'state': state,
          'postcode': '',
          'email': email,
          'phone': phone,
        },
        'line_items': selecteditems,

        'shipping_lines': [
          {
            'method_id': shoppingmethods.id,
            'method_title': shoppingmethods.title,
            'total': shoppingmethods.settings!.cost!.value
          }
        ],
      };
      data = data1;
    }

    String url = Server.mainapi +
        "/orders?consumer_key=${Server.consumer_key}&consumer_secret=${Server.secret_key}";
    // String url = Server.mainurl +
    //     "/wp-json/api/flutter_order/create?consumer_key=${Server.consumer_key}&consumer_secret=${Server.secret_key}";

    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    try {
      response = await dio.post(url, data: convert.jsonEncode(data));
      // print(response.data);

      return response.data;
      // print();
    } on DioError catch (e) {
      print(e);
      throw "Error Coming From order";
    }

    // response = await Dio().post(
    //   url,
    //   data: order,
    //   // options: diooption.Options(headers: {
    //   //   // 'User-Cookie': user.user != null ? user.user!.cookie! : '',
    //   //   'Content-Type': 'application/json'
    //   // })
    // );
  }

  Future<Response> updateorder(int user, int orderid) async {
    Response response;
    var dataus = <String, dynamic>{'customer_id': user};
    String url = Server.mainapi +
        "/orders/$orderid?consumer_key=${Server.consumer_key}&consumer_secret=${Server.secret_key}";

    response = await Dio().put(url, data: dataus);
    // print(response.data);
    return response;
  }

  Future<bool> Setreview({
    required int pid,
    required String review,
    required String reviewer,
    required String email,
    required String rating,
  }) async {
    var data = <String, dynamic>{
      'product_id': pid,
      'review': review,
      'reviewer': reviewer,
      'reviewer_email': email,
      'rating': rating
    };
    Response response;
    // String url = Server.mainurl +
    //     "/wp-json/api/flutter_woo/products/reviews?consumer_key=${Server.consumer_key}&consumer_secret=${Server.secret_key}";
    String url = Server.mainapi +
        "/products/reviews?consumer_key=${Server.consumer_key}&consumer_secret=${Server.secret_key}";

    print(data);
    try {
      response = await Dio().post(url, data: convert.jsonEncode(data));
      print(response.statusCode);
      if (response.statusCode == 201) {
        // print(convert.JsonDecoder(response.data));
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      print(e);
      return false;
      // throw "Error Coming From order";
    }
  }

  Future<List<reviewModel>> getreview({required String email}) async {
    Response response;
    String url = Server.mainapi +
        "/products/reviews?consumer_key=${Server.consumer_key}&consumer_secret=${Server.secret_key}&reviewer_email=$email";

    try {
      response = await Dio().get(url);
      var data =
          (response.data as List).map((e) => reviewModel.fromJson(e)).toList();
      return data;
    } on DioError catch (e) {
      print(e);

      throw "Error Coming From order";
    }
  }
}
