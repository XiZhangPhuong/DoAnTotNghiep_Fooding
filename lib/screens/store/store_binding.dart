import 'package:fooding_project/screens/store/store_controller.dart';
import 'package:get/get.dart';

class StoreBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => StoreController());
  }

}