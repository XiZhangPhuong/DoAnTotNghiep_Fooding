import 'package:fooding_project/screens/cart/cart_controller.dart';
import 'package:fooding_project/screens/home/home_controller.dart';
import 'package:get/get.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    // put all controller in dashboard
    Get.put(() => HomeController());
    Get.put(() => CartController());
  }
}
