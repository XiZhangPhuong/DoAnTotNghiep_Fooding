import 'package:fooding_project/screens/auth/singup/singup_controller.dart';
import 'package:get/get.dart';


class SingupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingupController>(() => SingupController());
  }
}
