import 'package:dokanpat/configs/woocommerce_api.dart';
import 'package:dokanpat/model/product_model.dart';
import 'package:dokanpat/services/woo_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:get_storage/get_storage.dart';

import '../configs/key_value.dart';

class ProductController extends GetxController {
  //late productModel _products;
  final _box = GetStorage();

  var _productsall = <productModel>[].obs;
  var _dailyproducts = <productModel>[].obs;
  var _newproducts = <productModel>[].obs;
  var _searchproducts = <productModel>[].obs;

  var _categoypeoductslist = <productModel>[].obs;

  RxList<productModel> get mainproduct => _productsall;
  RxList<productModel> get dailyproducts => _dailyproducts;
  RxList<productModel> get newproducts => _newproducts;
  RxList<productModel> get searchproducts => _searchproducts;

  // RxList<productModel> get categoypeoductslist => _categoypeoductslist;

  int pagenumbe = 1;
  int dailypage = 1;
  int newarrivalpage = 1;
  int searchpage = 1;
  // int catpage = 1;
  String oldsearch = '';
  bool onsearchloading = false;
  bool dailylast = false;
  bool newarrivallast = false;
  bool loading = false;
  String sortby = 'popularity';

  String newarival_sortby = 'date';
  String daily_sortby = 'popularity';
  int newarrival = 402;
  int dailyneeds = 460;

  bool progress = false;
  RxBool nwprogress = false.obs;
  RxBool dyprogress = false.obs;
  RxBool searchprogress = false.obs;
  DateTime now = new DateTime.now();
  // RxBool categoryprogress = false.obs;

  @override
  void onReady() {
    int _day = int.parse(_box.read(ConstKey.today).toString() == 'null'
        ? '0'
        : _box.read(ConstKey.today).toString());
    if (_day != now.day) {
      newarival();
      dailyproduct();
      getproduct();
    } else {
      storedatafunction();
    }

    super.onReady();
  }

  void reloadfunction() {
    newarival();
    dailyproduct();
    getproduct();
  }

  void storedatafunction() {
    var _newp = _box.read(ConstKey.newproducts);

    List<productModel> finalnew =
        (_newp as List).map((e) => productModel.fromJson(e)).toList();
    _newproducts.value = finalnew;

    var _dailyp = _box.read(ConstKey.dailyproducts);

    List<productModel> finaldaily =
        (_dailyp as List).map((e) => productModel.fromJson(e)).toList();
    _dailyproducts.value = finaldaily;

    var _mainp = _box.read(ConstKey.mainproduct);
    List<productModel> finalmainp =
        (_mainp as List).map((e) => productModel.fromJson(e)).toList();
    _productsall.value = finalmainp;

    pagenumbe = 2;
    dailypage = 2;
    newarrivalpage = 2;

    if (_productsall.isEmpty ||
        _newproducts.isEmpty ||
        _dailyproducts.isEmpty) {
      newarival();
      dailyproduct();
      getproduct();
    }
  }

  void dailyproduct() async {
    dyprogress.value = true;
    update();

    var products = await WooServices().getproducts(
        pagenumber: 1,
        pagesize: 12,
        category: dailyneeds,
        sortBy: 'popularity',
        sortOrder: 'desc');
    //List<productModel> data =
    _dailyproducts.clear();
    _dailyproducts.value += products;
    dailypage = 2;

    print('--- dailyproduct --- ' + products.length.toString());
    dyprogress.value = false;
    _box.remove(ConstKey.dailyproducts);
    _box.write(ConstKey.dailyproducts, _dailyproducts);

    update();
  }

  void filterdailyproduct({String? sortBy, String sortOrder = 'desc'}) async {
    dyprogress.value = true;
    loading = true;
    if (sortBy != daily_sortby) {
      dailypage = 1;
      _dailyproducts.clear();
    }
    daily_sortby = sortBy.toString();
    update();

    var products = await WooServices().getproducts(
        pagenumber: dailypage,
        category: dailyneeds,
        pagesize: 12,
        sortBy: daily_sortby == 'price1' ? 'price' : daily_sortby,
        sortOrder: sortOrder);
    //List<productModel> data =
    if (products.length == 0) {
      dailylast = true;
    }

    _dailyproducts.value += products;
    dailypage += 1;

    print('--- dailyproduct --- ' + products.length.toString());
    dyprogress.value = false;
    loading = false;

    update();
  }

  void newarival() async {
    nwprogress.value = true;
    update();

    var products = await WooServices().getproducts(
        pagenumber: 1,
        category: newarrival,
        pagesize: 16,
        sortBy: 'date',
        sortOrder: 'desc');
    //List<productModel> data =
    _newproducts.clear();
    _newproducts.value += products;

    print('*** New product ***' + products.length.toString());
    nwprogress.value = false;
    newarrivalpage = 2;

    update();
    _box.remove(ConstKey.newproducts);
    _box.write(ConstKey.newproducts, _newproducts);
  }

  void filternewarival({String? sortBy, String sortOrder = 'desc'}) async {
    nwprogress.value = true;
    loading = true;

    if (sortBy.toString() != newarival_sortby) {
      print(sortBy.toString());
      _newproducts.clear();
      newarrivalpage = 1;
    }
    newarival_sortby = sortBy.toString();
    update();

    print(newarrivalpage.toString() + '===' + _newproducts.length.toString());

    var products = await WooServices().getproducts(
        pagenumber: newarrivalpage,
        category: newarrival,
        pagesize: 16,
        sortBy: newarival_sortby == 'price1' ? 'price' : newarival_sortby,
        sortOrder: sortOrder);
    //List<productModel> data =
    if (products.length == 0) {
      newarrivallast = true;
    }
    _newproducts.value += products;

    newarrivalpage += 1;

    print('*** New product ***' + products.length.toString());
    nwprogress.value = false;
    loading = false;

    update();
  }

  void getproduct() async {
    var products =
        await WooServices().getproducts(pagesize: 16, sortOrder: 'desc');
    //List<productModel> data =
    _productsall.clear();
    _productsall.value = products;
    pagenumbe = 2;

    print('=== Product ====' + mainproduct.length.toString());
    _box.remove(ConstKey.mainproduct);
    _box.write(ConstKey.mainproduct, _productsall);
    update();
  }

  void updateRandomProduct() async {
    progress = true;
    update();

    var products = await WooServices()
        .getproducts(pagenumber: pagenumbe, pagesize: 16, sortOrder: 'desc');
    //List<productModel> data =
    _productsall.value += products;
    print('-------------' + pagenumbe.toString());
    progress = false;
    pagenumbe += 1;

    update();
  }

  void searchProduct(String search,
      {String? sortBy, String sortOrder = 'desc'}) async {
    if (search.toString().toLowerCase() != oldsearch.toLowerCase()) {
      searchprogress.value = true;
      _searchproducts.clear();
      oldsearch = search;
      sortby = 'popularity';
      searchpage = 1;
    } else {
      onsearchloading = true;
      if (searchpage == 1 || sortBy != sortby) {
        _searchproducts.clear();
        searchpage = 1;
      }
      sortby = sortBy.toString();
    }

    update();

    var products = await WooServices().getproducts(
        pagenumber: searchpage,
        pagesize: 14,
        search: search,
        sortBy: sortby == 'price1' ? 'price' : sortby,
        sortOrder: sortOrder);
    //List<productModel> data =
    _searchproducts.value += products;
    searchprogress.value = false;
    onsearchloading = false;
    searchpage += 1;
    print('ok');

    update();
  }

  // void getcategoryProduct() async {
  //   categoryprogress.value = true;
  //   int id = int.parse(Get.parameters['id'].toString());
  //   update();
  //   catpage += 1;
  //   var products = await WooServices()
  //       .getproducts(pagenumber: pagenumbe, pagesize: 30, sortOrder: 'desc');

  //   //List<productModel> data =
  //   _categoypeoductslist.value += products;

  //   categoryprogress.value = false;
  //   print(categoypeoductslist.length);

  //   update();
  // }
}
