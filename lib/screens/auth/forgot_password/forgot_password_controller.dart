import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes_path/auth_routes.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController phoneEditingController = TextEditingController();

  ///
  /// Go to OTP.
  ///
  void gotoOTP() {
    Get.toNamed(
      AuthRoutes.OTP,
      arguments: [
        "forgot",
        phoneEditingController.text,
      ],
    );
  }
}
