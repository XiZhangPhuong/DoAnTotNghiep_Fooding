// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

import '../../helper/izi_dimensions.dart';
import '../../utils/color_resources.dart';

class ButtonFooding extends StatelessWidget {
  String text;
  Color colorButton;
  Function ontap;
  double border;
  ButtonFooding({
    Key? key,
    required this.text,
    this.colorButton = ColorResources.colorMain,
    required this.ontap,
    required this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        height: IZIDimensions.ONE_UNIT_SIZE * 90,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
          horizontal: IZIDimensions.iziSize.width * 0.1,
        ),
        decoration: BoxDecoration(
          color: colorButton,
          borderRadius: BorderRadius.circular(
            border,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: ColorResources.WHITE,
            fontWeight: FontWeight.w700,
            fontSize: IZIDimensions.FONT_SIZE_SPAN,
            fontFamily: 'Manrope',
          ),
        ),
      ),
    );
  }
}
