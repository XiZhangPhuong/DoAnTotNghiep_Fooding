// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fooding_project/screens/bottombar/bottombar_controller.dart';
import 'package:get/get.dart';

class BottomBarPage extends GetView<BottomBarController> {
  const BottomBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: BottomBarController(),
      builder: (controller) {
        return Scaffold(
           bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.curenIndex.value,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: controller.pages[0]['label'],
                
              ),
               BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: controller.pages[1]['label'],
                
              ),
               BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard),
                label: controller.pages[2]['label'],
                
              ),
               BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: controller.pages[3]['label'],               
              ),
            ],
           ),

           body: Obx(() => controller.pages[controller.curenIndex.value]['page']),
        );
      }, 
    );
  }
}