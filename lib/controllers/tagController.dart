import 'package:dokanpat/model/product_model.dart';
import 'package:dokanpat/model/review_model.dart';
import 'package:dokanpat/services/woo_services.dart';
import 'package:get/get.dart';

class TagController extends GetxController {
  var singleproduct;
  bool progrss = false;
  bool categoryprogress = false;
  int catpage = 1;
  String finaltag = '';
  String sortby = 'popularity';

  var _review = <reviewModel>[].obs;
  RxList<reviewModel> get review => _review;

  var _productsall = <productModel>[].obs;
  RxList<productModel> get categoryProduct => _productsall;

  // var _categoypeoductslist = <productModel>[].obs;
  // RxList<productModel> get categoypeoductslist => _categoypeoductslist;

  @override
  void onInit() {
    String tag = Get.parameters['tagid'].toString();
    finaltag = tag;

    //int catid = int.parse(Get.parameters['catid'].toString());

    productbytag(tag);
    super.onInit();
  }

  void productbytag(String tag) async {
    categoryprogress = true;

    update();
    var products = await WooServices()
        .getproducts(pagesize: 20, tag: tag, sortBy: sortby, sortOrder: 'desc');
    //List<productModel> data =
    _productsall.value = products;

    print('category product ' + products.length.toString());
    categoryprogress = false;
    catpage += 1;
    update();
  }

  void getcategoryProduct(String? sortBy, {String sortOrder = 'desc'}) async {
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
        tag: finaltag,
        sortBy: sortby == 'price1' ? 'price' : sortby,
        sortOrder: sortOrder);
    //List<productModel> data =
    _productsall.value += products;
    categoryprogress = false;
    print('Category Product ' + categoryProduct.length.toString());
    catpage += 1;

    update();
  }
}
