import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/repository/auth_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../helper/izi_validate.dart';
import '../../../routes/routes_path/auth_routes.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController phoneEditingController = TextEditingController();
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();
  final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();
  @override
  void onInit() {
    super.onInit();
    phoneEditingController.text = Get.arguments as String;
  }

  @override
  void dispose() {
    super.dispose();
    phoneEditingController.dispose();
  }

  ///
  /// Go to OTP.
  ///
  Future<void> gotoOTP() async {
    if (validateForgotpassword()) {
      if (await _userRepository.checPhone(phoneEditingController.text)) {
        await _authRepository.phoneAuthentication(phoneEditingController.text);
        await await Get.toNamed(
          AuthRoutes.OTP,
          arguments: [
            "forgot",
            phoneEditingController.text.substring(1),
          ],
        );
      } else {
        IZIAlert().error(message: "Số điện thoại này không có");
      }
    }
  }

  ///
  /// Validate Forgot password.
  ///
  bool validateForgotpassword() {
    if (IZIValidate.nullOrEmpty(phoneEditingController.text)) {
      IZIAlert().error(message: "Số điện thoại không được để trống");
      return false;
    } else if (phoneEditingController.text.length != 10) {
      IZIAlert().error(message: "Số điện thoại phải 10 ký tự");
      return false;
    }
    return true;
  }
}
