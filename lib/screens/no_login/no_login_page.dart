import 'package:flutter/material.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:fooding_project/screens/components/button_app.dart';
import 'package:fooding_project/screens/no_login/no_login_controller.dart';
import 'package:get/get.dart';

class NoLoginPage extends GetView {
  const NoLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: NoLoginController(),
        builder: (controller) {
          return SizedBox(
            height: IZIDimensions.iziSize.height,
            width: IZIDimensions.iziSize.width,
            child: Center(
              child: ButtonFooding(
                text: "Đăng nhập",
                ontap: () {
                  Get.offAllNamed(AuthRoutes.LOGIN);
                },
                border: IZIDimensions.BORDER_RADIUS_4X,
              ),
            ),
          );
        },
      ),
    );
  }
}
