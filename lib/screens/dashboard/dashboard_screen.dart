import 'package:badges/badges.dart ' as badge;
import 'package:flutter/material.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/screens/dashboard/dashboard_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class BottomBarPage extends GetView<BottomBarController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BottomBarController(),
        builder: (BottomBarController controller) => WillPopScope(
              child: Scaffold(
                floatingActionButton: _floattingButton(controller),
                backgroundColor: Colors.white,
                body: Obx(() => controller.pages[controller.currentIndex.value]
                    ['page'] as Widget),
                bottomNavigationBar: bottomNavigator(context),
              ),
              onWillPop: () => controller.onDoubleBack(),
            ));
  }

  Widget onSelected(BuildContext context,
      {required String title, required String icon, required int index}) {
    return Material(
      child: GestureDetector(
        onTap: () => controller.onChangedPage(index),
        child: SizedBox(
          width: IZIDimensions.iziSize.width / controller.pages.length,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder(
                builder: (BottomBarController controller) {
                  return SizedBox(
                    height: IZIDimensions.SPACE_SIZE_5X,
                    child: Image.asset(
                      icon,
                      color: controller.currentIndex.value == index
                          ? ColorResources.colorMain
                          : const Color.fromRGBO(103, 114, 117, 1),
                    ),
                  );
                },
              ),
              Obx(
                () => Text(
                  title,
                  style: TextStyle(
                    color: controller.currentIndex.value == index
                        ? ColorResources.colorMain
                        : const Color.fromRGBO(103, 114, 117, 1),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNavigator(BuildContext context) {
    return BottomAppBar(
      clipBehavior: Clip.hardEdge,
      color: ColorResources.WHITE,
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: IZIDimensions.SPACE_SIZE_5X * 3,
        width: IZIDimensions.iziSize.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              controller.pages.length,
              (index) {
                return Container(
                  color: Colors.transparent,
                  child: onSelected(
                    context,
                    title: controller.pages[index]['label'].toString(),
                    index: index,
                    icon: controller.pages[index]['icon'],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

///
/// floatting button cart
///
Widget _floattingButton(BottomBarController controller) {
  return controller.listProductsCard.isEmpty
      ? Container()
      : FloatingActionButton(
          backgroundColor: ColorResources.WHITE,
          onPressed: () {
            controller.gotoCart();
          },
          child: badge.Badge(
            badgeContent: Text(
              controller.listProductsCard.length.toString(),
              style: TextStyle(
                color: ColorResources.WHITE,
                fontFamily: NUNITO,
                fontWeight: FontWeight.w600,
                fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
              ),
            ),
            child: Icon(
              Icons.shopping_cart,
              size: IZIDimensions.ONE_UNIT_SIZE * 40,
              color: ColorResources.RED,
            ),
          ),
        );
}
