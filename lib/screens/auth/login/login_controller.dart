import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/app_constants.dart';
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
  bool isCheck = false;

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
      EasyLoading.show(status: "Đang đăng nhập");
      User? user =
          await _userRepository.getUserDetails(phoneEditingController.text);
      if (user != null) {
        if (user.typeUser != CUSTOMER ||
            !BCrypt.checkpw(
              passwordEditingController.text,
              user.passWord!,
            )) {
          IZIAlert().error(
            message: "Tài khoản hoặc mật khẩu sai",
          );
          EasyLoading.dismiss();
          return;
        }
        if (user.isDeleted!) {
          IZIAlert().error(
            message:
                "Tài khoản của bạn hiện đang bị khóa, Vui lòng liên hệ Admin",
          );
          EasyLoading.dismiss();
          return;
        }
        sl<SharedPreferenceHelper>().setIdUser(user.id!);
        IZIAlert().success(message: "Đăng nhập thành công");
        if (isCheck) {
          sl<SharedPreferenceHelper>().setLogged(status: true);
        } else {
          sl<SharedPreferenceHelper>().setLogged(status: false);
        }
        Get.offAllNamed(AuthRoutes.DASHBOARD);
      } else {
        if (await _userRepository.checPhone(phoneEditingController.text)) {
          IZIAlert().error(message: "Thông tin đăng nhập chưa chính xác");
        } else {
          IZIAlert().error(message: "Tài khoản chưa được đăng kí");
        }
      }
      EasyLoading.dismiss();
    }
  }

  ///
  /// Go to forgot Password.
  ///
  void goToForgotPassword() {
    Get.toNamed(
      AuthRoutes.FORGOT_PASSWORD,
      arguments: phoneEditingController.text,
    );
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
    } else if (phoneEditingController.text.length != 10) {
      IZIAlert().error(message: "Số điện thoại phải 10 ký tự");
      return false;
    } else if (IZIValidate.nullOrEmpty(passwordEditingController.text)) {
      IZIAlert().error(message: "Mật khẩu không được để trống");
      return false;
    } else if (passwordEditingController.text.length < 6) {
      IZIAlert().error(message: "Mật khẩu phải 6 ký tự");
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
