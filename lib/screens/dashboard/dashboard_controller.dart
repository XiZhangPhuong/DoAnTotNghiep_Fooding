
import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/screens/cart/cart_pages.dart';
import 'package:fooding_project/screens/home/home_screen.dart';
import 'package:fooding_project/screens/profile/profile_page.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';


class BottomBarController extends GetxController {
  final List<Map<String, dynamic>> pages = [
    {
      'label': "Home",
      'icon': ImagesPath.icon_trangchu,
      'page': const HomeScreenPage(),
    },
    {
      'label': "Yêu thích",
      'icon': ImagesPath.icon_trangchu,
      'page': const HomeScreenPage(),
    },
    {
      'label': "Giỏ hàng",
      'icon': ImagesPath.icon_taikhoan,
      'page': const CartPage(),
    },
    {
      'label': "Tài khoản",
      'icon': ImagesPath.icon_taikhoan,
      'page': const ProfilePage() ,
    },
  ];

  DateTime? currentBackPressTime;
  RxInt currentIndex = 0.obs;
  double sizeIcon = 24.0;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments.runtimeType == int) {
        currentIndex.value = Get.arguments as int;
      }
    }
  }

  ///
  /// Change page
  ///
  void onChangedPage(int index) {
    currentIndex.value = index;
    update();
  }

  /// double back press
  Future<bool> onDoubleBack() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      IZIAlert().info(message: "Do you want exit the application.");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void onClose() {
    currentIndex.close();
    super.onClose();
  }
}
