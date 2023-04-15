import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/izi_dimensions.dart';
import '../../utils/color_resources.dart';

class AppBarFooding extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool isLeading;
  AppBarFooding({
    super.key,
    required this.title,
    this.isLeading = true,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorResources.colorMain,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: IZIDimensions.FONT_SIZE_SPAN * 1.2,
        ),
      ),
      leading: isLeading
          ? GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: IZIDimensions.SPACE_SIZE_2X,
                  top: IZIDimensions.SPACE_SIZE_1X,
                  right: IZIDimensions.SPACE_SIZE_1X,
                  bottom: IZIDimensions.SPACE_SIZE_1X,
                ),
                height: IZIDimensions.ONE_UNIT_SIZE * 100,
                width: IZIDimensions.ONE_UNIT_SIZE * 50,
                decoration: const BoxDecoration(
                  color: ColorResources.WHITE,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: IZIDimensions.SPACE_SIZE_1X * 1.5,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: ColorResources.colorTextTabbar,
                  ),
                ),
              ),
            )
          : const SizedBox(),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(IZIDimensions.ONE_UNIT_SIZE * 5),
        child: Container(),
      ),
    );
  }

  @override
  final Size preferredSize;
}
