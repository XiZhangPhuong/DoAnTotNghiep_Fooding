import 'package:flutter/material.dart';
import 'package:fooding_project/screens/cart/cart_pages.dart';
import 'package:fooding_project/screens/dashboard/dashboard_controller.dart';
import 'package:fooding_project/screens/home/home_screen.dart';
import 'package:fooding_project/screens/profile/profile_page.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class DashBoardScreen extends GetView {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashBoardController(),
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: const Color(0xffABC4AA),
            unselectedItemColor: ColorResources.BLACK,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.curenIndex.value,
            onTap: (value) {
              controller.changePage(value);
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: controller.pages[0]['label'],
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.favorite),
                label: controller.pages[1]['label'],
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_cart),
                label: controller.pages[2]['label'],
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.people),
                label: controller.pages[3]['label'],
              ),
            ],
          ),
          body: IndexedStack(
            index: controller.curenIndex.value,
            children: const [
              HomeScreenPage(),
              CartPage(),
              CartPage(),
              ProfilePage(),
            ],
          ),
        );
      },
    );
  }
}
