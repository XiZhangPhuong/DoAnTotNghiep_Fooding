import 'package:fooding_project/screens/SHIPPER/home_shipper/home_shipper_controller.dart';
import 'package:get/get.dart';

class HomeShipperBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeShipperController());
  }

}