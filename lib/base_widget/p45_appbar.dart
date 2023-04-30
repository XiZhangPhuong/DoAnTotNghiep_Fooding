 import 'package:flutter/material.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';
class P45AppBarP extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isShowLeadingIcon;
  const  P45AppBarP(
      {Key? key, required this.title, this.isShowLeadingIcon = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorResources.colorMain,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'Nunito',
          fontSize: IZIDimensions.FONT_SIZE_SPAN*1.2,
        ),
      ),
      leading: isShowLeadingIcon
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
          : null,
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}