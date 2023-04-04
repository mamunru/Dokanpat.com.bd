import 'dart:convert';
import 'dart:math';

import 'package:dokanpat/configs/api_url.dart';
import 'package:dokanpat/configs/key_value.dart';
import 'package:dokanpat/configs/server.dart';
import 'package:dokanpat/model/banner_model.dart';
import 'package:dokanpat/model/category_model.dart';
import 'package:dokanpat/model/onscreensms_model.dart';
import 'package:dokanpat/model/sms_model.dart';
import 'package:dokanpat/model/token_model.dart';
import 'package:dokanpat/services/api_services.dart';
import 'package:dokanpat/widgets/dailog_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TokenController extends GetxController {
  String token = ''.obs();
  late token_model tokenlist;
  final _box = GetStorage();
  bannerModel? _banner;
  bool bannerprogrss = false;
  bool catprogress = false;
  // _productsall = <bannerModel>[].obs;
  var _category = <Option>[].obs;
  bool onnotification = false;

  bannerModel get banner => _banner!;
  RxList<Option> get category => _category;

  var _sms = <smsModel>[].obs;
  RxList<smsModel> get sms => _sms;
  DateTime now = new DateTime.now();

  @override
  void onReady() {
    //  initHome();
    onnotification = _box.read(ConstKey.onnotificationcount) ?? true;
    int _day = int.parse(_box.read(ConstKey.today).toString() == 'null'
        ? '0'
        : _box.read(ConstKey.today).toString());
    if (_day != now.day) {
      getcategory();
      getbanner();
      //
    } else {
      storedatafunction();
    }
    //onNotificationFunction();
    //getnotification();

    //
    super.onReady();
  }

  void reloadfunction() {
    getcategory();
    getbanner();
  }

  void storedatafunction() {
    var _bannersql = _box.read(ConstKey.banner);
    // jsonDecode(bannerdata.body)

    //var bannerBox = jsonDecode(_bannersql);
    //print(jsonEncode(_bannersql));

    Map<String, dynamic> jsonMap = jsonDecode(jsonEncode(_bannersql));
    List<Mainbanner> mainbanner = (jsonMap['mainbanner'] as List)
        .map((e) => Mainbanner.fromJson(e))
        .toList();
    List<Singlebanner> singlebanner = (jsonMap['singlebanner'] as List)
        .map((e) => Singlebanner.fromJson(e))
        .toList();
    List<Specialbanner> specialbanner = (jsonMap['specialbanner'] as List)
        .map((e) => Specialbanner.fromJson(e))
        .toList();

    _banner = bannerModel(
        mainbanner: mainbanner,
        singlebanner: singlebanner,
        specialbanner: specialbanner);
    //print(data);

    var _categorysql = _box.read(ConstKey.category);

    //Option
    List<Option> categorysql =
        (_categorysql as List).map((e) => Option.fromJson(e)).toList();
    _category.value = categorysql;

    if (_category.isEmpty || _banner.isBlank!) {
      getcategory();
      getbanner();
    }
  }

  initHome() async {
    if (_box.read(ConstKey.token) != null) {
      token = _box.read(ConstKey.token);
      print('=========== token store ==========');
    } else {
      var data = await ApiService().gettoken();

      if (data['data'] == 401) {
        //  print('===========' + data.toString());
      } else {
        tokenlist = token_model.fromJson(data['data']);
        _box.write(ConstKey.token, tokenlist.token);
        token = tokenlist.token!;
      }

      print(token);
    }
    update();
  }

  void getbanner() async {
    bannerprogrss = true;
    var bannerdata = await ApiService().getmethod(url: apiUrl.banner);

    if (bannerdata != null) {
      //var decotedata = jsonDecode(bannerdata.data);
      // print(bannerdata.data);

      _banner = bannerModel.fromJson(bannerdata.data);
      update();
      _box.remove(ConstKey.banner);
      _box.write(ConstKey.banner, _banner);

      //print('===========' + banner.toString());
    } else {
      //GetDailogPage(title: "title", details: bannerdata.statusCode.toString());
      print('====================No Data from banner api section===========');
    }

    bannerprogrss = false;

    update();
  }

  void getcategory() async {
    catprogress = true;
    update();
    var category = await ApiService().getapilistdata(url: apiUrl.childCategory);
    if (category.data != null) {
      List<Option> items =
          (category.data as List).map((data) => Option.fromJson(data)).toList();
      _category.clear();
      _category.value = items;

      update();
      _box.remove(ConstKey.category);
      _box.write(ConstKey.category, _category);
    } else {
      print('====================No Data from category api section===========');
      // Get.defaultDialog(
      //     title: "Thank You For Singup", middleText: category.data);
    }

    catprogress = false;

    update();
  }

  void storetoken(String token) async {
    int userid = int.parse(_box.read(ConstKey.userid));
    String name = _box.read(ConstKey.username).toString() == 'null'
        ? 'Guest'
        : _box.read(ConstKey.username);
    ;
    ApiService().storetoken(token, userid, name);
  }

  void getnotification() async {
    _box.write(ConstKey.onnotificationcount, false);
    int userid = int.parse(_box.read(ConstKey.userid));
    var data = await ApiService().getmessage(userid);
    _sms.value = data;
    onnotification = false;

    update();
  }

  void onNotificationFunction() {
    onnotification = true;
    _box.write(ConstKey.onnotificationcount, true);
    update();
  }
}
