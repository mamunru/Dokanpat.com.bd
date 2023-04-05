import 'package:dokanpat/controllers/cartController.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../configs/key_value.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  bool onloading = false;
  final box = GetStorage();

  @override
  void onReady() {
    //Get.offAllNamed("/testpage");
    LoadingHome();
    super.onReady();
  }

  // @override
  // void onInit() {
  //   Get.offAllNamed("/testpage");
  //   super.onInit();
  // }

  LoadingHome() async {
    onloading = true;
    bool isFirstLaunch = box.read(ConstKey.isFirstLaunch) ?? true;
    if (isFirstLaunch) {
      print('------------------------error--------------');
      box.write(ConstKey.onnotificationcount, false);
      //box.write('isFirstLaunch', false);
      box.write(ConstKey.stateid, 'BD-00');
      box.write(ConstKey.statename, 'Select Your Location');
      box.write(ConstKey.userid, '0');
      box.write(ConstKey.token, '0');
      // Get.offAllNamed("/homepage");
    }

    update();
    await Future.delayed(const Duration(seconds: 2));

    navigatedToIntroduction();
    update();
  }

  void navigatedToIntroduction() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    switch (connectivityResult) {
      case ConnectivityResult.mobile:
        Get.offAllNamed("/homepage");
        onloading = false;
        break;
      case ConnectivityResult.wifi:
        //Get.offAllNamed('/nointernet');

        Get.offAllNamed("/homepage");
        onloading = false;

        break;
      case ConnectivityResult.none:
        Get.offAllNamed('/nointernet');
        onloading = false;
        break;
      case ConnectivityResult.bluetooth:
        Get.offAllNamed('/nointernet');
        onloading = false;
        break;
      case ConnectivityResult.ethernet:
        Get.offAllNamed("/homepage");
        onloading = false;

        break;
      case ConnectivityResult.vpn:
        Get.offAllNamed("/homepage");
        onloading = false;
        break;
      case ConnectivityResult.other:
        Get.offAllNamed('/nointernet');
        onloading = false;
        break;
    }

    update();
  }

  void storedata({required String name, required String id}) {
    box.write(ConstKey.stateid, id);
    box.write(ConstKey.statename, name);
    box.write(ConstKey.isFirstLaunch, false);
    CartController cartcontroller = Get.find();
    cartcontroller.setlocatonandGoHome(name, id);

    if (id == 'BD-12' || id == 'BD-39') {
      box.write(ConstKey.locationtag, 'home delelivery');
      // Get.toNamed('/');
    } else {
      box.write(ConstKey.locationtag, '');
    }
    update();
  }
}
