import 'package:fooding_project/screens/SHIPPER/dash_board_shipper/dash_board_shipper_controller.dart';
import 'package:fooding_project/screens/SHIPPER/home_shipper/home_shipper_controller.dart';
import 'package:get/get.dart';

class DashBoardBindingShipper extends Bindings {
  @override
  void dependencies() {
    // put all controller in dashboard
    Get.lazyPut<BottomBarShipperController>(() => BottomBarShipperController());
     Get.lazyPut<HomeShipperController>(() => HomeShipperController());
    // Get.lazyPut<ProfileController>(() => ProfileController());
  }
}