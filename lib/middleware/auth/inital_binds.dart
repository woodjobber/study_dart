import 'package:get/get.dart';
import 'user_controller.dart';

class InitialBindings extends Bindings {
  final controller = UserController();
  bool initialized = false;

  @override
  void dependencies() {
    // 其实是多余的. initialized
    if (initialized) {
      return;
    }
    initialized = true;
    print('>>>>> InitialBindings');
    Get.put(controller);
  }
}
