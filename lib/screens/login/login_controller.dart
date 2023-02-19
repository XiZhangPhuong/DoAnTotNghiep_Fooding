import 'package:fooding_project/routes/routes_path/login_routes.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  @override
  void onInit() {
    
    super.onInit();
  }

  void gotoBottomBar(){
    Get.toNamed(LoginRoutes.BOTTOMAPPBAR);
  }
}