import 'package:fooding_project/screens/auth/otp/otp_controller.dart';
import 'package:get/get.dart';

class OTPBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OTPController>(() => OTPController());
  }
}
