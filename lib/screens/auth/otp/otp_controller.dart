import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/repository/auth_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class OTPController extends GetxController {
  final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();
  bool isClick = false;
  Timer? timer;
  int count = 50;
  String otpCode = '';
  var result = [];

  @override
  void onInit() {
    super.onInit();
    result = Get.arguments as List<String>;
    countDown();
  }

  ///
  /// Count down.
  ///
  void countDown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count < 1) {
        isClick = true;
      } else {
        --count;
        update();
      }
    });
  }

  ///
  /// On page change.
  ///
  Future<void> onPageChange() async {
    if (result[0] == "create") {
      EasyLoading.show(status: "Đang cập nhật dữ liệu");
      try {
        if (otpCode.isNotEmpty) {
          final credential = await _authRepository.verifyOTP(otpCode);

          if (credential.user != null) {
            IZIAlert().success(message: "Đăng kí tài khoản thành công");

            // Add data to FireStore.
            await _userRepository.addUser(
              result[1],
              result[2],
              credential.user!.uid,
            );
            EasyLoading.dismiss();
            Get.close(2);
          } else {
            IZIAlert().error(message: "Mã OTP không đúng hoặc OTP hết hạn");
          }
        } else {
          IZIAlert().error(message: "Mã OTP đang trống");
        }
      } catch (e) {
        EasyLoading.dismiss();
        IZIAlert().error(message: "Mã OTP không đúng hoặc OTP hết hạn");
      }
    } else {
      try {
        if (otpCode.isNotEmpty) {
          final credential = await _authRepository.verifyOTP(otpCode);
          if (credential.user != null) {
            Get.offNamed(
              AuthRoutes.RESET,
              arguments: credential.user!.uid,
            );
          } else {
            IZIAlert().error(message: "Mã OTP không đúng hoặc OTP hết hạn");
          }
        } else {
          IZIAlert().error(message: "Mã OTP đang trống");
        }
      } catch (e) {
        IZIAlert().error(message: "Mã OTP không đúng hoặc OTP hết hạn");
      }
    }
  }
}
