import 'package:flutter/material.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../base_widget/izi_alert.dart';
import '../../../helper/izi_validate.dart';

class ResetPasswordController extends GetxController {
  //
  // Declare API
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();

  @override
  void dispose() {
    super.dispose();
    passwordEditingController.dispose();
    confirmPasswordController.dispose();
  }

  ///
  /// Validate singup.
  ///
  bool validateSingup() {
    if (IZIValidate.nullOrEmpty(passwordEditingController.text)) {
      IZIAlert().error(message: "Mật khẩu không được để trống");
      return false;
    } else if (IZIValidate.nullOrEmpty(confirmPasswordController.text)) {
      IZIAlert().error(message: "Nhập lại mật khẩu không được để trống");
      return false;
    } else if (passwordEditingController.text.length < 6 ||
        confirmPasswordController.text.length < 6) {
      IZIAlert().error(message: "mật khẩu phải lớn hơn 6 ký tự");
      return false;
    } else if (passwordEditingController.text
            .compareTo(confirmPasswordController.text) !=
        0) {
      IZIAlert().error(message: "Mật khẩu không trùng");
      return false;
    }
    return true;
  }

  ///
  /// Update password.
  ///
  Future<void> updatePassword() async {
    if (validateSingup()) {
      try {
        User user = User();
        user.passWord = passwordEditingController.text;
        await _userRepository.updateUser(
          user,
          Get.arguments as String,
        );
        Get.close(2);
        IZIAlert().success(message: "Đã đặt lại mật khẩu");
      } catch (e) {
        IZIAlert().error(message: "Hãy kiểm tra lại thông tin");
        print(e.toString());
      }
    }
  }
}
