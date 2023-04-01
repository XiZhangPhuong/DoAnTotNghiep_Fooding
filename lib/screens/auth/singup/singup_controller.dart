import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:get/get.dart';

class SingupController extends GetxController {
  void gotoOTP() {
    Get.toNamed(
      AuthRoutes.OTP,
      arguments: "create",
    );
  }
}
