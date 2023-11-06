import 'package:get/get.dart';

class UserController extends GetxService {
  static UserController get findOr {
    try {
      return Get.find<UserController>();
    } catch (e) {
      //get controller is not initialized yet
      Get.put(UserController());
      return Get.find<UserController>();
    }
  }

  //this object is declared as Rx in order to be reactive in the UI inside the Obx Widget
  Rx<bool> isUserLoggedIn = false.obs;
}
