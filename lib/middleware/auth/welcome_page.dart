import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 248, 252, 1),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
              child: TextButton(
            onPressed: () {
              controller.isUserLoggedIn.value =
                  !controller.isUserLoggedIn.value;
            },
            child: Obx(
              //we need the Obx Widget in order for the text to change reactively
              () => Text(controller.isUserLoggedIn.value
                  ? 'Log out user '
                  : 'Log in user'),
            ),
          )),
        ),
      ),
    );
  }
}
