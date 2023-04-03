import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/screens/home/home_controller.dart';
import 'package:get/get.dart';

class HomeScreenPage extends GetView<HomeController> {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(IZIDimensions.BORDER_RADIUS_5X),
                child: IZIImage(
                  'https://images.foody.vn/res/g95/947982/prof/s640x400/foody-upload-api-foody-mobile-68376773_26762228859-190814144905.jpg',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
