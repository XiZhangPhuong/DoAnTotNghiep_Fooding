import 'package:fooding_project/screens/cart/cart_controller.dart';
import 'package:fooding_project/screens/dashboard/dashboard_controller.dart';
import 'package:fooding_project/screens/home/home_controller.dart';
import 'package:get/get.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    // put all controller in dashboard
    Get.lazyPut<DashBoardController>(() => DashBoardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CartController>(() => CartController());
  }
}
