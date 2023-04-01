import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes_path/auth_routes.dart';

class LoginController extends GetxController {
  //Init value.
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  bool isCheck = true;

  @override
  void dispose() {
    super.dispose();
    phoneEditingController.dispose();
  }

  void gotoDashBoard() {
    Get.toNamed(AuthRoutes.DASHBOARD);
  }

  void goToForgotPassword() {
    Get.toNamed(AuthRoutes.FORGOT_PASSWORD);
  }

  void goToSingUp() {
    Get.toNamed(AuthRoutes.SINGUP);
  }
}
