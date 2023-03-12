
import 'package:fooding_project/routes/routes_path/dash_board_routes.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  void goToDashBoard() {
    Get.toNamed(DashBoardRoutes.DASHBOARD);
  }
}
