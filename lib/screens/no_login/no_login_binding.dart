import 'package:fooding_project/screens/no_login/no_login_controller.dart';
import 'package:get/get.dart';

class NoLoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NoLoginController());
  }

}