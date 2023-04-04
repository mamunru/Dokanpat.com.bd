import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dokanpat/configs/api_url.dart';
import 'package:dokanpat/configs/server.dart';
import 'package:dokanpat/model/category_model.dart';
import 'package:dokanpat/model/onscreensms_model.dart';
import 'package:dokanpat/model/sms_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final http.Client _httpClient;

  ApiService({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  Future<http.Response> get(String path) async {
    final url = '${Server.secondapi}';

    final response = await _httpClient.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Error getting data from the API');
    }
    return response;
  }

  Future<Map<String, dynamic>> gettoken() async {
    Response response;
    var dio = Dio();
    dio.options.baseUrl = Server.secondapi;
    // dio.options.connectTimeout = 5000; //5s
    // dio.options.receiveTimeout = 3000;

    List<Map<String, dynamic>> data = [];

    var formData = FormData.fromMap({
      'key': Server.apikey,
      'password': Server.password,
    });

    try {
      response = await dio.post('/login', data: formData);
      return {'data': response.data};
    } on DioError catch (e) {
      print(e);
      //data.add(e);
      return {'data': 401};
    }

    //return response.data;
  }

  Future<Response> getmethod<T>({required String url, String? token}) async {
    Response response;
    String parameter = '';

    // if (token != null) {
    //   parameter += "?token=$token";
    // }
    var dio = Dio();
    final urlgo = '${Server.secondapi}$url';
    print(urlgo);

    try {
      response = await dio.get(urlgo);

      return response;
    } on DioError catch (e) {
      print(e);
      throw "Error Coming From $e";
    }
  }

  Future<Response> getapilistdata({required String url}) async {
    Response response;

    String finalurl = '${Server.secondapi}$url';
    print(finalurl);
    try {
      response = await Dio().get(finalurl);

      return response;
    } on DioError catch (e) {
      print(e);
      throw "Error Coming From $finalurl";
    }
  }

  void storetoken(String token, int userid, String name) async {
    Response response;
    var formData = FormData.fromMap({
      'name': name,
      'token': token,
      'userid': userid,
    });

    String finalurl = '${Server.secondapi}${apiUrl.storeuser}';

    try {
      response = await Dio().post(finalurl, data: formData);
    } on DioError catch (e) {
      print(e);
      //data.add(e);
    }
  }

  Future<List<smsModel>> getmessage(int id) async {
    Response response;
    try {
      String finalurl = '${Server.secondapi}${apiUrl.getnotification}$id';
      response = await Dio().get(
        finalurl,
      );
      final items = (response.data as List)
          .map((data) => smsModel.fromJson(data))
          .toList();

      return items;
    } on DioError catch (e) {
      print(e);
      throw "Error Coming From message";
    }
  }

  Future<List<onscreensmsModel>> onscreensms() async {
    Response response;
    try {
      String finalurl = '${Server.secondapi}${apiUrl.onscreennotification}';
      response = await Dio().get(
        finalurl,
      );
      final items = (response.data as List)
          .map((data) => onscreensmsModel.fromJson(data))
          .toList();

      return items;
    } on DioError catch (e) {
      print(e);
      throw "Error Coming From Review";
    }
  }
}
