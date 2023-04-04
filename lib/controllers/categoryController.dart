import 'package:dokanpat/model/product_model.dart';
import 'package:dokanpat/model/review_model.dart';
import 'package:dokanpat/services/woo_services.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var singleproduct;
  bool progrss = false;
  bool categoryprogress = false;
  int catpage = 1;
  int parentpage = 1;
  int catid = 0;
  int catpagesub = 1;
  String sortby = 'popularity';

  var _review = <reviewModel>[].obs;
  RxList<reviewModel> get review => _review;

  var _productsall = <productModel>[].obs;
  RxList<productModel> get categoryProduct => _productsall;

  // var _categoypeoductslist = <productModel>[].obs;
  // RxList<productModel> get categoypeoductslist => _categoypeoductslist;

  @override
  void onInit() {
    int id = int.parse(Get.parameters['id'].toString());
    catid = id;
    //int catid = int.parse(Get.parameters['catid'].toString());

    relatedproduct(id);
    super.onInit();
  }

  void productbytag() async {
    categoryprogress = true;
    var tag = Get.parameters['tagid'].toString();
    update();
    var products = await WooServices()
        .getproducts(pagesize: 20, tag: tag, sortOrder: 'desc');
    //List<productModel> data =
    _productsall.value += products;

    print('category product ' + products.length.toString());
    categoryprogress = false;
    catpage += 1;

    update();
  }

  void relatedproduct(int catid) async {
    categoryprogress = true;
    update();
    var products = await WooServices().getproducts(
        pagesize: 20, category: catid, sortBy: sortby, sortOrder: 'desc');
    //List<productModel> data =
    _productsall.value += products;

    print('category product ' + products.length.toString());
    categoryprogress = false;
    catpage += 1;
    update();
  }

  void subproduct(int catid) async {
    categoryprogress = true;
    _productsall.clear();
    update();
    var products = await WooServices().getproducts(
        pagesize: 20, category: catid, sortBy: sortby, sortOrder: 'desc');
    //List<productModel> data =
    _productsall.value += products;

    print('category product ' + products.length.toString());
    categoryprogress = false;
    catpagesub += 1;
    update();
  }

  void getcategoryProduct(int? cid, int pid, String? sortBy,
      {String sortOrder = 'desc'}) async {
    categoryprogress = true;
    if (sortBy != sortby) {
      _productsall.clear();
      catpage = 1;
    }
    sortby = sortBy.toString();
    update();

    var products = await WooServices().getproducts(
        pagenumber: catpage,
        pagesize: 20,
        category: cid,
        sortBy: sortby == 'price1' ? 'price' : sortby,
        sortOrder: sortOrder);
    //List<productModel> data =
    if (products.length == 0) {
      var products = await WooServices().getproducts(
          pagenumber: parentpage,
          pagesize: 16,
          category: pid,
          sortOrder: 'desc');
      _productsall.value += products;
      parentpage += 1;
      update();
    } else {
      parentpage = 1;
      _productsall.value += products;
      update();
    }
    //_productsall.value += products;

    categoryprogress = false;
    print('Category Product ' + categoryProduct.length.toString());
    catpage += 1;

    update();
  }
}
