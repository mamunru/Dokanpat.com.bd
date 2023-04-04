import 'package:dokanpat/model/product_model.dart';
import 'package:dokanpat/model/review_model.dart';
import 'package:dokanpat/services/woo_services.dart';
import 'package:get/get.dart';

import '../model/productimage_model.dart';

class ProductFilterController extends GetxController {
  var singleproduct;
  bool progrss = false;
  bool categoryprogress = false;
  int catpage = 1;
  bool onrelativeproductloding = false;
  bool progress = false;
  int catid = 0;
  int categoryindex = 0;

  var _review = <reviewModel>[].obs;
  RxList<reviewModel> get review => _review;

  productModel? productinfo;

  var _productsall = <productModel>[].obs;
  RxList<productModel> get mainproduct => _productsall;

  var _productimage = <ProductImageModel>[].obs;
  RxList<ProductImageModel> get productimage => _productimage;

  var _categoypeoductslist = <productModel>[].obs;
  RxList<productModel> get categoypeoductslist => _categoypeoductslist;

  @override
  void onInit() {
    int id = int.parse(Get.parameters['id'].toString());
    catid = int.parse(Get.parameters['catid'].toString());
    update();

    // getproductinfo(Get.arguments as productModel);
    callReviewapi(id);
    relatedproduct(catid);

    super.onInit();
  }

  void ProductById(productModel data) {
    progrss = true;
    productinfo = Get.arguments as productModel;
    progrss = false;
    update();
  }

  void getproductinfo(productModel data) {
    progrss = true;

    _productimage.clear();

    data.images!.forEach((element) {
      _productimage.add(
          ProductImageModel(name: element.id.toString(), src: element.src));
    });
    progrss = false;
    update();
  }

  void relatedproduct(int catid) async {
    onrelativeproductloding = true;
    var products = await WooServices()
        .getproducts(pagesize: 16, category: catid, sortOrder: 'desc');
    //List<productModel> data =
    _productsall.value = products;

    print('category product ' + products.length.toString());
    onrelativeproductloding = false;
    update();
  }

  void callReviewapi(int id) async {
    _review.clear();
    var data = await WooServices().ReviewApi(id);

    print('------------id---------' + id.toString());

    // data.forEach(
    //   (element) {
    //     if (element.productId == id) {
    //       //print(element.reviewer);
    //       _review.add(element);
    //     }
    //   },
    // );
    _review.value = data;
    print(review.length.toString());

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
        _productsall.value += products;
        update();
      }
    } else {
      _productsall.value += products;
      update();
    }

    categoryprogress = false;
    progress = false;

    update();
  }

  //void updateRandomProduct(List<Categories> catlist) async {}
}
