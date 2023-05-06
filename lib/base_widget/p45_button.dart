import 'package:flutter/material.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/utils/color_resources.dart';
class P45Button extends StatelessWidget {
  final String title;
  final Function()  onPressed;
  final Color? color;
  const P45Button({super.key, required this.title, required this.onPressed,this.color});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: IZIDimensions.ONE_UNIT_SIZE * 80,
        margin: EdgeInsets.only(
            left: IZIDimensions.SPACE_SIZE_5X,
            right: IZIDimensions.SPACE_SIZE_5X,
            bottom: IZIDimensions.SPACE_SIZE_1X),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(IZIDimensions.SPACE_SIZE_1X),
          color:color ?? ColorResources.colorMain,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Nunito',
              color: ColorResources.WHITE,
              fontSize: IZIDimensions.FONT_SIZE_H6,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}