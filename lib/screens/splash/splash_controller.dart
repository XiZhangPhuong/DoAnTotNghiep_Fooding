import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../di_container.dart';
import '../../routes/routes_path/auth_routes.dart';
import '../../sharedpref/shared_preference_helper.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //
  // Declare DATA
  late AnimationController? _animationController;

  @override
  void onInit() {
    super.onInit();
    _setStatusLogin();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController!.dispose();
  }

  ///
  /// check status logged in or not.
  ///
  void _setStatusLogin() {
    //
    // install _animationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );

    // check logged in or not.
    _animationController!.forward().whenComplete(
      () async {
        final splash = sl<SharedPreferenceHelper>().getSplash;
        final isLogged = sl<SharedPreferenceHelper>().getLogged;

        // Check if first login app.
        if (splash) {
          if (isLogged) {
            Get.offNamed(AuthRoutes.HOME_SHIPPER);
          } else {
            Get.offNamed(AuthRoutes.LOGIN);
          }
        } else {
          Get.offNamed(AuthRoutes.INTRODUCTION);
        }
      },
    );
  }
}
