import 'dart:async';

import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  bool isClick = false;
  Timer? timer;
  int count = 50;

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

  void onPageChange() {
    String result = Get.arguments as String;
    if (result == "create") {
      Get.close(2);
    } else {
      Get.toNamed(
        AuthRoutes.RESET,
      );
    }
  }
}
