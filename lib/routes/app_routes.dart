import 'package:dokanpat/controllers/categoryController.dart';
import 'package:dokanpat/controllers/loginController.dart';
import 'package:dokanpat/controllers/mydrawer_controller.dart';
import 'package:dokanpat/controllers/onlineProductController.dart';
import 'package:dokanpat/controllers/orderhistory_controller.dart';
import 'package:dokanpat/controllers/product_controller.dart';
import 'package:dokanpat/controllers/product_filter_controller.dart';
import 'package:dokanpat/controllers/tagController.dart';
import 'package:dokanpat/controllers/wishliatController.dart';
import 'package:dokanpat/routes/test.dart';
import 'package:dokanpat/screens/cart/cart_products.dart';
import 'package:dokanpat/screens/category/allcategorypages.dart';
import 'package:dokanpat/screens/checkout/checkout_page.dart';
import 'package:dokanpat/screens/locationscreen.dart';
import 'package:dokanpat/screens/orders/order_history.dart';
import 'package:dokanpat/screens/orders/thankyou_page.dart';
import 'package:dokanpat/screens/pages/privacy_page.dart';
import 'package:dokanpat/screens/payment/webpage.dart';
import 'package:dokanpat/screens/products/banner_product.dart';
import 'package:dokanpat/screens/products/category_page.dart';
import 'package:dokanpat/screens/products/details/details.dart';
import 'package:dokanpat/screens/products/details/online_details.dart';
import 'package:dokanpat/screens/products/product_seemore.dart';

import 'package:dokanpat/screens/splash/splash_page.dart';
import 'package:dokanpat/screens/user/login_page.dart';
import 'package:dokanpat/screens/user/singup_page.dart';
import 'package:dokanpat/screens/user/user_login_dailog.dart';
import 'package:dokanpat/screens/webview/webview.dart';
import 'package:dokanpat/screens/wishlist/wishlist.dart';
import 'package:dokanpat/widgets/onscreendailog.dart';
import 'package:get/get.dart';

import '../controllers/allCategoryController.dart';
import '../screens/home/cart_screen.dart';
import '../screens/homepage.dart';
import '../screens/nointernet_page.dart';
import '../screens/pages/about.dart';
import '../screens/products/details/single_product_online.dart';
import '../screens/products/tag_product_page.dart';
import '../screens/search/search_page.dart';

class Approutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => SplashPage()),
        GetPage(name: "/nointernet", page: () => NoInpernet()),
        // GetPage(name: "/locationscreen", page: () => LocationSCreen()),
        GetPage(
            name: "/testpage",
            page: () => Test(),
            binding: BindingsBuilder(() {
              Get.put(MyDrawerController());
            })),
        GetPage(
            name: "/homepage",
            page: () => HomePage(),
            binding: BindingsBuilder(() {
              Get.put(MyDrawerController());
            })),

        GetPage(
          transition: Transition.rightToLeft,
          name: "/back/homepage",
          page: () => HomePage(),
        ),

        GetPage(
          transition: Transition.leftToRight,
          name: "/privacy",
          page: () => PrivacyPAge(),
        ),
        //Contactus
        GetPage(
          transition: Transition.leftToRight,
          name: "/contactus",
          page: () => Contactus(),
        ),

        GetPage(
            transition: Transition.leftToRight,
            //transitionDuration: Duration(seconds: 0.3),
            name: "/product_details/:id/:catid",
            page: () => ProductDetails(),
            binding: BindingsBuilder(() {
              Get.put(ProductFilterController());
            })
            // parameters: Get.parameters[''],
            ),

        GetPage(
            transition: Transition.leftToRight,
            //transitionDuration: Duration(seconds: 0.3),
            name: "/product_details/online/:id/:catid",
            page: () => OnlineProductDetails(),
            binding: BindingsBuilder(() {
              Get.put(OnlineProductFilterController());
            })
            // parameters: Get.parameters[''],
            ),

        GetPage(
            transition: Transition.leftToRight,
            //transitionDuration: Duration(seconds: 0.3),
            name: "/cart/product_details/online/:id/:catid",
            page: () => SingleProductOnline(),
            binding: BindingsBuilder(() {
              Get.put(OnlineProductFilterController());
            })
            // parameters: Get.parameters[''],
            ),
        GetPage(
          // transition: Transition.leftToRight,
          name: '/search',
          page: () => SearchPage(),
        ),

        GetPage(
          transition: Transition.leftToRight,
          name: '/all/category',
          page: () => AllCategoryPage(),
          // binding: BindingsBuilder(() {
          //   Get.put(allCategoryController());
          // })
        ),

        //daily Need
        GetPage(
            transition: Transition.leftToRight,
            name: '/product/daily_need',
            page: () => ProductSeemore(),
            binding: BindingsBuilder(() {
              Get.put(ProductController().dailyproduct());
            })),
        //New Arrival
        GetPage(
            transition: Transition.leftToRight,
            name: '/product/new_arrival',
            page: () => ProductSeemore(),
            binding: BindingsBuilder(() {
              Get.put(ProductController().newarival());
            })),

        GetPage(
            transition: Transition.leftToRight,
            name: '/product/category/:id/:pid',
            page: () => CategoryPage(),
            binding: BindingsBuilder(() {
              Get.put(CategoryController());
            })),

        GetPage(
            transition: Transition.leftToRight,
            name: '/product/banner/:id',
            page: () => BannerProductPage(),
            binding: BindingsBuilder(() {
              Get.put(CategoryController());
            })),

        GetPage(
            transition: Transition.leftToRight,
            name: '/product/by/tag/:tagid',
            page: () => TagProductPage(),
            binding: BindingsBuilder(() {
              Get.put(TagController());
            })),

        GetPage(
          transition: Transition.leftToRight,
          name: '/shopping/cart',
          page: () => CartScreen(),
        ),

        GetPage(
          transition: Transition.leftToRight,
          name: '/checkout',
          page: () => CheckOutPage(),
        ),

        GetPage(
          transition: Transition.leftToRight,
          name: '/wishlist',
          page: () => Wishlist(),
        ),

        GetPage(
          // transition: Transition.leftToRight,
          name: '/webview',
          page: () => WebPagePayment(),
        ),

        GetPage(
          // transition: Transition.leftToRight,
          name: '/login',
          page: () => LoginPage(),
          // binding: BindingsBuilder(() {
          //   Get.put(loginController());
          // })
        ),

        GetPage(
          // transition: Transition.leftToRight,
          name: '/singup',
          page: () => SingUpPage(),
        ),

        GetPage(
            // transition: Transition.leftToRight,
            name: '/order/thank',
            page: () => ThankYouPage()),

        GetPage(
            name: '/order/history',
            page: () => OrderHistory(),
            binding: BindingsBuilder(() {
              Get.put(OrderHistoryContriller());
            })),
        GetPage(
          name: '/buynow/login',
          page: () => UserLoginDailog(),
          fullscreenDialog: true,
          transition: Transition.downToUp,
        ),

        //webview page
        GetPage(
          transition: Transition.leftToRight,
          //transitionDuration: Duration(seconds: 0.3),
          name: "/webview/:name",
          page: () => WebviewPage(),

          // parameters: Get.parameters[''],
        ),

        GetPage(
          name: '/onscreen',
          page: () => OnscreenDailog(),
          fullscreenDialog: true,
          transition: Transition.downToUp,
        ),
      ];
}
