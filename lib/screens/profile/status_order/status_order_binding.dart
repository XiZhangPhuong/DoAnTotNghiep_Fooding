import 'package:fooding_project/screens/profile/status_order/status_order_controller.dart';
import 'package:get/get.dart';

class StatusOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatusOrderController>(() => StatusOrderController());
  }
}
