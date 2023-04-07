import 'package:flutter/material.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../base_widget/izi_alert.dart';
import '../../../di_container.dart';
import '../../../helper/izi_validate.dart';
import '../../../model/user.dart';
import '../../../routes/routes_path/auth_routes.dart';

class LoginController extends GetxController {
  //
  // Declare API
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();

  //Init value.
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  bool isCheck = true;

  @override
  void dispose() {
    super.dispose();
    phoneEditingController.dispose();
    passwordEditingController.dispose();
  }

  ///
  /// Go to DashBoard.
  ///
  Future<void> gotoDashBoard() async {
    if (validateLogin()) {
      User? user = await _userRepository.getUserDetails(
          phoneEditingController.text, passwordEditingController.text);
      if (user != null) {
        sl<SharedPreferenceHelper>().setIdUser(user.id!);
        IZIAlert().success(message: "Đăng nhập thành công");
        if (isCheck) {
          sl<SharedPreferenceHelper>().setLogged(status: true);
        } else {
          sl<SharedPreferenceHelper>().setLogged(status: false);
        }
        Get.toNamed(AuthRoutes.DASHBOARD);
      } else {
        if (await _userRepository.checPhone(phoneEditingController.text)) {
          IZIAlert().error(message: "Tài khoản hoặc mật khẩu sai");
        } else {
          IZIAlert().error(message: "Tài khoản chưa được đăng kí");
        }
      }
    }
  }

  ///
  /// Go to forgot Password.
  ///
  void goToForgotPassword() {
    Get.toNamed(AuthRoutes.FORGOT_PASSWORD);
  }

  ///
  /// Go to sing up.
  ///
  void goToSingUp() {
    Get.toNamed(AuthRoutes.SINGUP);
  }

  bool validateLogin() {
    if (IZIValidate.nullOrEmpty(phoneEditingController.text)) {
      IZIAlert().error(message: "Số điện thoại không được để trống");
      return false;
    } else if (IZIValidate.nullOrEmpty(passwordEditingController.text)) {
      IZIAlert().error(message: "Mật khẩu không được để trống");
      return false;
    } else if (phoneEditingController.text.length != 10) {
      IZIAlert().error(message: "Số điện thoại phải 10 ký tự");
      return false;
    } else if (!IZIValidate.phoneNumber(phoneEditingController.text)) {
      IZIAlert().error(message: "Số điện thoại không đúng định dạng");
      return false;
    }
    return true;
  }

  void oncheckboxChange(bool status) {
    isCheck = status;
    update();
  }
}
