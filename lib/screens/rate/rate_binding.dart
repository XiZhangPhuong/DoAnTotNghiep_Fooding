import 'package:fooding_project/screens/rate/rate_controller.dart';
import 'package:get/get.dart';

class RateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RateController());
  }
}
