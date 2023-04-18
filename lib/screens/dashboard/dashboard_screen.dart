import 'package:flutter/material.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/screens/dashboard/dashboard_controller.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class BottomBarPage extends GetView<BottomBarController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BottomBarController(),
        builder: (BottomBarController controller) => WillPopScope(
              child: Scaffold(
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
