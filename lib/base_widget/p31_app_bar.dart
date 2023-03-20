// ignore_for_file: avoid_field_initializers_in_const_classes

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../utils/color_resources.dart';
import '../helper/izi_dimensions.dart';

class P31AppBar extends StatefulWidget implements PreferredSizeWidget {
  const P31AppBar({
    Key? key,
    required this.label,
    this.isLeadingIcon = true,
    this.leadingIcon,
    this.actions,
    this.background,
    this.labelTextStyle,
    this.isLeadingIconButton,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  State<P31AppBar> createState() => _P31AppBarState();

  final String label;
  final bool? isLeadingIcon;
  final Widget? leadingIcon;
  final List<Widget>? actions;
  final Color? background;
  final TextStyle? labelTextStyle;
  final Icon? isLeadingIconButton;
}

class _P31AppBarState extends State<P31AppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.background ?? ColorResources.PRIMARY_1,
      elevation: 0,
      centerTitle: true,
      title: Text(
        widget.label,
        style: widget.labelTextStyle ??
            TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: IZIDimensions.FONT_SIZE_H5,
              color: ColorResources.WHITE,
            ),
      ),
      actions: widget.actions,
      // ignore: prefer_if_null_operators
      leading: widget.leadingIcon == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: IZIDimensions.ONE_UNIT_SIZE * 60,
                    height: IZIDimensions.ONE_UNIT_SIZE * 60,
                    decoration: const BoxDecoration(
                      color: ColorResources.WHITE,
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: IZIDimensions.ONE_UNIT_SIZE * 18,
                          top: IZIDimensions.ONE_UNIT_SIZE * 15,
                          child: widget.isLeadingIconButton ??
                              Icon(
                                Icons.arrow_back_ios,
                                color: ColorResources.BLACK,
                                size: IZIDimensions.ONE_UNIT_SIZE * 30,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : widget.leadingIcon,
    );
  }
}
