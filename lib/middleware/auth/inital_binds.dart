import 'package:get/get.dart';
import 'user_controller.dart';

class InitialBindings extends Bindings {
  final controller = UserController();
  bool initialed = false;
  @override
  void dependencies() {
    if (initialed) {
      return;
    }
    initialed = true;
    print('>>>>> InitialBindings');
    Get.put(controller);
  }
}
