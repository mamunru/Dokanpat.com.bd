import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dokanpat/configs/server.dart';
import 'package:dokanpat/configs/woocommerce_api.dart';
import 'package:dokanpat/model/product_model.dart';
import 'package:dokanpat/model/review_model.dart';
import 'package:dokanpat/services/woo_services.dart';
import 'package:get/get.dart';

import '../model/productimage_model.dart';

class OnlineProductFilterController extends GetxController {
  productModel? singleproduct;

  bool progrss = false;
  bool categoryprogress = false;
  int catpage = 1;
  bool onrelativeproductloding = false;
  bool progress = false;
  int catid = 0;
  int categoryindex = 0;
  bool onlineproduct = false;

  var _onlinedata = <productModel>[].obs;
  //RxList<productModel> get onlinedata => _onlinedata;

  Rx<productModel> onlinedata = Rx<productModel>(productModel()).obs();

  var _review = <reviewModel>[].obs;
  RxList<reviewModel> get review => _review;

  productModel? productinfo;

  var _productsall = <productModel>[].obs;

  RxList<productModel> get mainproduct => _productsall;

  var _productimage = <ProductImageModel>[].obs;
  RxList<ProductImageModel> get productimage => _productimage;

  var _categoypeoductslist = <productModel>[].obs;
  RxList<productModel> get categoypeoductslist => _categoypeoductslist;

  //List<ProductImageModel> _productimage = [];

  @override
  void onInit() {
    int id = int.parse(Get.parameters['id'].toString());
    catid = int.parse(Get.parameters['catid'].toString());

    if (catid == 0) {
      getsingleproductinfo(id);
    } else {
      getproductinfo(id);
      callReviewapi(id);
      relatedproduct(catid);
    }

    super.onInit();
  }

  void ProductById(productModel data) {
    progrss = true;
    productinfo = Get.arguments as productModel;
    progrss = false;
    update();
  }

  void getsingleproductinfo(int id) async {
    onlineproduct = true;
    update();
    String url =
        "${Server.mainapi}${woocommerce.products}/$id?consumer_key=${Server.consumer_key}&consumer_secret=${Server.secret_key}";

    var response = await Dio().get(url);
    var oniledata = productModel.fromJson(response.data);
    //_onlinedata.add(onlinedata);
    this.onlinedata.value = oniledata;

    //List image = [];
    oniledata.images!.forEach(
      (e) {
        _productimage.add(ProductImageModel(src: e.src, name: e.name));
      },
    );
    // print(_productimage.length);
    onlineproduct = false;
    update();
    callReviewapi(id);
    relatedproduct(oniledata.categories![0].id!);

    update();
  }

  void getproductinfo(int id) async {
    progrss = true;
    singleproduct = Get.arguments as productModel;
    update();
    String url =
        "${Server.mainapi}${woocommerce.products}/$id?consumer_key=${Server.consumer_key}&consumer_secret=${Server.secret_key}";
    var response = await Dio().get(url);
    productModel oniledata = productModel.fromJson(response.data);

    singleproduct!.price = oniledata.price;
    singleproduct!.variationProducts = oniledata.variationProducts;
    progrss = false;
    update();
  }

  void relatedproduct(int catid) async {
    onrelativeproductloding = true;
    var products = await WooServices()
        .getproducts(pagesize: 30, category: catid, sortOrder: 'desc');
    //List<productModel> data =
    _productsall.value = products;

    print('category product ${products.length}');
    onrelativeproductloding = false;
    update();
  }

  void callReviewapi(int id) async {
    _review.clear();
    List data = await WooServices().ReviewApi(id);

    //print('------------id---------' + id.toString());

    data.forEach(
      (element) {
        if (element.productId == id) {
          //print(element.reviewer);
          _review.add(element);
        }
      },
    );
    print(review.length.toString());

    update();
  }

  void getcategoryProduct() async {
    categoryprogress = true;
    int id = int.parse(Get.parameters['id'].toString());
    update();
    // catpage += 1;
    var products = await WooServices().getproducts(
        pagenumber: catpage, pagesize: 16, category: id, sortOrder: 'desc');
    //List<productModel> data =
    _categoypeoductslist.value = products;
    categoryprogress = false;
    print('Category Product ${_categoypeoductslist.length}');

    update();
  }

  void updateRandomProduct(List<Categories> catlist) async {
    categoryprogress = true;
    progress = true;
    //int id = int.parse(Get.parameters['id'].toString());
    update();
    catpage += 1;
    var products = await WooServices().getproducts(
        pagenumber: catpage,
        pagesize: 16,
        category: catlist[categoryindex].id,
        sortOrder: 'desc');
    //List<productModel> data =
    if (products.length == 0) {
      catpage = 1;
      if (categoryindex + 1 < catlist.length) {
        categoryindex += 1;

        var products = await WooServices().getproducts(
            pagenumber: 1,
            pagesize: 16,
            category: catlist[categoryindex].id,
            sortOrder: 'desc');
        products.map((e) {});
        _productsall.value += products;
        update();
      }
    } else {
      _productsall.value += products;
      update();
    }

    print(catlist[categoryindex].id);
    _productsall.removeWhere((item) =>
        _productsall.indexOf(item.id) != _productsall.lastIndexOf(item.id));

    categoryprogress = false;
    progress = false;

    update();
  }
}
