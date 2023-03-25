
import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  ///
  /// Go to Dash Board.
  ///
  void goToDashBoard() {
    Get.toNamed(AuthRoutes.DASHBOARD);
  }
}
