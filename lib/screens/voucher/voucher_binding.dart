import 'package:fooding_project/screens/voucher/voucher_controller.dart';
import 'package:get/get.dart';

class VoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VoucherController());
  }
}
