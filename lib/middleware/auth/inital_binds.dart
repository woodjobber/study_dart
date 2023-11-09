import 'package:get/get.dart';
import 'package:study_dart/run_once.dart';
import 'user_controller.dart';

class InitialBindings extends Bindings {
  final controller = UserController();

  @override
  void dependencies() {
    Once.run('&InitialBindings', () {
      print('>>>>> InitialBindings');
      Get.put(controller);
    });
  }
}
