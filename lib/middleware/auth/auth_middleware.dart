import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_dart/middleware/auth/user_controller.dart';

class AuthMiddleware extends GetMiddleware {
  final authService = Get.find<UserController>();
  @override
  int? get priority => -10;
  bool isAuthenticated = false;

  @override
  RouteSettings? redirect(String? route) {
    isAuthenticated = authService.isUserLoggedIn.value;
    if (isAuthenticated) {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}
