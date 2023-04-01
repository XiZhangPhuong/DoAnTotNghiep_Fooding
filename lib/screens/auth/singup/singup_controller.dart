import 'package:flutter/material.dart';
import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:get/get.dart';

import '../../../base_widget/izi_alert.dart';
import '../../../helper/izi_validate.dart';

class SingupController extends GetxController {
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneEditingController.dispose();
    passwordEditingController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  ///
  /// go to OTP.
  ///
  void gotoOTP() {
    Get.toNamed(
      AuthRoutes.OTP,
      arguments: ["create", phoneEditingController.text, passwordEditingController.text,],
    );
  }
  ///
  /// Validate singup.
  ///
  Future<bool> validateSingup() async {
    if (IZIValidate.nullOrEmpty(phoneEditingController.text)) {
      IZIAlert().error(message: "Số điện thoại không được để trống");
      return false;
    } else if (IZIValidate.nullOrEmpty(passwordEditingController.text)) {
      IZIAlert().error(message: "Mật khẩu không được để trống");
      return false;
    } else if (IZIValidate.nullOrEmpty(confirmPasswordController.text)) {
      IZIAlert().error(message: "Nhập lại mật khẩu không được để trống");
      return false;
    } else if (phoneEditingController.text.length != 10) {
      IZIAlert().error(message: "Số điện thoại phải 10 ký tự");
      return false;
    } else if (!IZIValidate.phoneNumber(phoneEditingController.text)) {
      IZIAlert().error(message: "Số điện thoại không đúng định dạng");
      return false;
    } else if (passwordEditingController.text.length < 6 || confirmPasswordController.text.length < 6) {
      IZIAlert().error(message: "password phải lớn hơn 6 ký tự");
      return false;
    } else if (passwordEditingController.text.compareTo(confirmPasswordController.text) != 0) {
      IZIAlert().error(message: "Mật khẩu không trùng");
      return false;
    } 
    return true;
  }
}
