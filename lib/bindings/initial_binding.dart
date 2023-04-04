import 'package:dokanpat/controllers/cartController.dart';
import 'package:dokanpat/controllers/home_controller.dart';
import 'package:dokanpat/controllers/loginController.dart';
import 'package:dokanpat/controllers/product_controller.dart';
import 'package:dokanpat/controllers/token_controller.dart';
import 'package:get/get.dart';

import '../controllers/mydrawer_controller.dart';
import '../controllers/theme_controller.dart';
import '../controllers/wishliatController.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(HomeController(), permanent: true);
    Get.put(ProductController(), permanent: true);
    Get.put(TokenController(), permanent: true);
    Get.put(CartController(), permanent: true);
    Get.put(loginController(), permanent: true);
    Get.put(WishListController(), permanent: true);
    // Get.lazyPut(() => FirebaseStorageServices());
  }
}
