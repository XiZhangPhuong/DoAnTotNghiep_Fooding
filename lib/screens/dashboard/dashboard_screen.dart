import 'package:flutter/material.dart';
import 'package:fooding_project/screens/dashboard/dashboard_controller.dart';
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
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.black,
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
                icon: const Icon(Icons.card_giftcard),
                label: controller.pages[2]['label'],
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.people),
                label: controller.pages[3]['label'],
              ),
            ],
          ),
          body:
              Obx(() => controller.pages[controller.curenIndex.value]['page']),
        );
      },
    );
  }
}
