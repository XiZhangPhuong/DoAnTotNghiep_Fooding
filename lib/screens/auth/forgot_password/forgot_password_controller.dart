import 'package:get/get.dart';

import '../../../routes/routes_path/auth_routes.dart';

class ForgotPasswordController extends GetxController {
  void gotoOTP() {
    Get.toNamed(
      AuthRoutes.OTP,
      arguments: "forgot",
    );
  }
}
