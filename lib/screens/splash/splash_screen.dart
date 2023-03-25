import 'package:flutter/material.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/screens/splash/splash_controller.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends GetView {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND,
      body: GetBuilder(
          init: SplashController(),
          builder: (SplashController controller) {
            return SizedBox(
              height: IZIDimensions.iziSize.height,
              width: IZIDimensions.iziSize.width,
              child: SafeArea(
                child: Center(
                  child: SizedBox(
                    height: IZIDimensions.iziSize.height * 0.5,
                    width: IZIDimensions.iziSize.width * 0.5,
                    child: Lottie.asset(
                      'assets/images/splash.json',
                      fit: BoxFit.fill,
                      height: IZIDimensions.iziSize.height * 0.5,
                      width: IZIDimensions.iziSize.width * 0.5,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
