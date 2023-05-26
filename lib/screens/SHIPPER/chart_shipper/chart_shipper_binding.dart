import 'package:fooding_project/screens/SHIPPER/chart_shipper/chart_shipper_controller.dart';
import 'package:get/get.dart';

class ChartShipperBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChartShipperController());
  }

}