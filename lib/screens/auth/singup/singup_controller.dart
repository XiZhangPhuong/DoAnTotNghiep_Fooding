import 'package:flutter/material.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../base_widget/izi_alert.dart';
import '../../../helper/izi_validate.dart';
import '../../../repository/auth_repository.dart';

class SingupController extends GetxController {
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();
  final _userRepository = GetIt.I.get<UserRepository>();
  @override
  void dispose() {
    super.dispose();
    phoneEditingController.dispose();
    passwordEditingController.dispose();
    confirmPasswordController.dispose();
  }

  ///
  /// go to OTP.
  ///
  Future<void> gotoOTP() async {
    if (await validateSingup()) {
      await _authRepository.phoneAuthentication(phoneEditingController.text);
      await Get.toNamed(
        AuthRoutes.OTP,
        arguments: [
          "create",
          phoneEditingController.text,
          passwordEditingController.text,
        ],
      );
    }
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
    } else if (passwordEditingController.text.length < 6 ||
        confirmPasswordController.text.length < 6) {
      IZIAlert().error(message: "password phải lớn hơn 6 ký tự");
      return false;
    } else if (passwordEditingController.text
            .compareTo(confirmPasswordController.text) !=
        0) {
      IZIAlert().error(message: "Mật khẩu không trùng");
      return false;
    } else if (await _userRepository.checPhone(phoneEditingController.text)) {
      IZIAlert().error(message: "Số điện thoại đã tồn tại");
      return false;
    }
    return true;
  }
}
