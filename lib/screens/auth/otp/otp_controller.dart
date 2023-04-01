import 'dart:async';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/repository/auth_repository.dart';
import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class OTPController extends GetxController {
  final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();
  bool isClick = false;
  Timer? timer;
  int count = 50;
  String otpCode = '';

  @override
  void onInit() {
    super.onInit();
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
    final result = Get.arguments as List<String>;
    if (result[0] == "create") {
      try {
        bool ischeck = await _authRepository.verifyOTP(otpCode);
        if (ischeck) {
          IZIAlert().success(message: "Đăng kí tài khoản thành công");

          // Add data to FireStore.
          Get.close(2);
        } else {
          IZIAlert().error(message: "Mã OTP không đúng hoặc OTP hết hạn");
        }
      } catch (e) {
        IZIAlert().error(message: "Mã OTP không đúng hoặc OTP hết hạn");
      }
    } else {
      Get.toNamed(
        AuthRoutes.RESET,
      );
    }
  }
}
