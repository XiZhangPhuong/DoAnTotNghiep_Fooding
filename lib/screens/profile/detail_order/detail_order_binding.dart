import 'package:fooding_project/screens/profile/detail_order/detail_order_controller.dart';
import 'package:get/get.dart';

class DetailOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailOrderController());
  }
}
