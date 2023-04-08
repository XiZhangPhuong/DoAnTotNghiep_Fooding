import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/screens/cart/cart_pages.dart';
import 'package:fooding_project/screens/dashboard/dashboard_controller.dart';
import 'package:fooding_project/screens/home/home_screen.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';

class DashBoardScreen extends GetView {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashBoardController(),
      builder: (DashBoardController controller ) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: const Color(0xfff64a4c),
            unselectedItemColor: const Color.fromRGBO(103, 114, 117, 1),
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
            unselectedFontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
            selectedLabelStyle: TextStyle(
                fontFamily: NUNITO,
                fontWeight: FontWeight.w600,
                fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL),
            unselectedLabelStyle: TextStyle(
                fontFamily: NUNITO,
                fontWeight: FontWeight.w600,
                fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL),
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
                icon: Badge(
                  badgeContent: Text(
                    '3',
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_DEFAULT * 0.8,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Nunito',
                      color: ColorResources.WHITE,
                    ),
                  ),
                  badgeColor: ColorResources.colorMain,
                  child: const Icon(Icons.shopping_cart),
                ),
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
              CartPage(),
            ],
          ),
        );
      },
    );
  }
}
