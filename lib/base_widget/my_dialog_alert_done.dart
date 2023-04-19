import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';


import '../helper/izi_dimensions.dart';
import '../helper/izi_validate.dart';
import '../utils/color_resources.dart';
import 'izi_button.dart';
import 'izi_image.dart';

class MyDialogAlertDone extends StatelessWidget {
  final double rotateAngle;
  final IconData icon;
  final String title;
  String? imagesIcon;
  final String description;
  final Color? color;
  final Function()? onTapConfirm;
  final Function()? onTapCancle;
  final Axis? direction;
  final TextAlign? textAlignDescription;
  MyDialogAlertDone({
    this.rotateAngle = 0,
    required this.icon,
    required this.title,
    required this.description,
    this.imagesIcon,
    this.color,
    this.onTapConfirm,
    this.onTapCancle,
    this.textAlignDescription,
    this.direction = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_5X,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_3X,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_4X,
          vertical: IZIDimensions.SPACE_SIZE_4X,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (direction == Axis.horizontal)
              Row(
                children: [
                  Align(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.NEUTRALS_2,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  if (imagesIcon != null)
                    IZIImage(
                      imagesIcon.toString(),
                      width: IZIDimensions.ONE_UNIT_SIZE * 40,
                      height: IZIDimensions.ONE_UNIT_SIZE * 40,
                    ),
                ],
              ),
            if (direction == Axis.vertical)
              Column(
                children: [
                  Align(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.NEUTRALS_2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  if (imagesIcon != null)
                    IZIImage(
                      imagesIcon.toString(),
                      width: IZIDimensions.ONE_UNIT_SIZE * 40,
                      height: IZIDimensions.ONE_UNIT_SIZE * 40,
                    ),
                ],
              ),
            SizedBox(
              height: IZIDimensions.SPACE_SIZE_2X,
            ),
            Padding(
              padding: EdgeInsets.only(
                right: IZIDimensions.SPACE_SIZE_3X,
              ),
              child: Text(
                description,
                textAlign: textAlignDescription ?? TextAlign.start,
                style: TextStyle(
                  color: ColorResources.NEUTRALS_4,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: IZIDimensions.iziSize.height * 0.02,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!IZIValidate.nullOrEmpty(onTapCancle))
                    GestureDetector(
                      onTap: () {
                        onTapCancle!();
                      },
                      child: Text(
                        "THOÁT",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                          color: ColorResources.RED,
                        ),
                      ),
                    ),
                  SizedBox(
                    width: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  if (!IZIValidate.nullOrEmpty(onTapConfirm))
                    GestureDetector(
                      onTap: () {
                        onTapConfirm!();
                      },
                      child: Text(
                        "ĐỒNG Ý",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                          color: ColorResources.PRIMARY_1,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DialogCustom extends StatelessWidget {
  final double rotateAngle;
  final IconData? icon;
  final String? imagesIcon;
  final String description;
  final Color? color;
  final Function()? onTapConfirm;
  final Function()? onTapCancle;
  const DialogCustom({
    this.rotateAngle = 0,
    this.icon,
    required this.description,
    this.imagesIcon,
    this.color,
    this.onTapConfirm,
    this.onTapCancle, required String agree, required String cancel1,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_5X,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_3X,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_4X,
          vertical: IZIDimensions.SPACE_SIZE_4X,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                if (imagesIcon != null)
                  AvatarGlow(
                    glowColor: ColorResources.COLOR_DIALOG,
                    duration: const Duration(milliseconds: 1500),
                    endRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
                    child: Container(
                      padding: EdgeInsets.all(
                        IZIDimensions.SPACE_SIZE_2X,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.COLOR_DIALOG.withOpacity(.15),
                      ),
                      child: IZIImage(
                        imagesIcon.toString(),
                        fit: BoxFit.contain,
                        width: IZIDimensions.ONE_UNIT_SIZE * 40,
                        height: IZIDimensions.ONE_UNIT_SIZE * 40,
                      ),
                    ),
                  )
                else
                  AvatarGlow(
                    glowColor: ColorResources.COLOR_DIALOG,
                    duration: const Duration(milliseconds: 1500),
                    endRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
                    child: Container(
                      padding: EdgeInsets.all(
                        IZIDimensions.SPACE_SIZE_2X,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.COLOR_DIALOG.withOpacity(.15),
                      ),
                      child: Icon(
                        icon ?? Icons.check,
                        size: IZIDimensions.ONE_UNIT_SIZE * 40,
                        color: color ?? ColorResources.GREEN,
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(
              height: IZIDimensions.SPACE_SIZE_2X,
            ),
            Padding(
              padding: EdgeInsets.only(
                right: IZIDimensions.SPACE_SIZE_3X,
              ),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: IZIDimensions.iziSize.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!IZIValidate.nullOrEmpty(onTapCancle))
                  Expanded(
                    child: IZIButton(
                      colorBG: ColorResources.WHITE,
                      colorText: ColorResources.PRIMARY_1,
                      onTap: () {
                        onTapCancle!();
                      },
                      label: 'HỦY',
                      fontSizedLabel: IZIDimensions.FONT_SIZE_SPAN,
                      padding: EdgeInsets.all(
                        IZIDimensions.ONE_UNIT_SIZE * 14,
                      ),
                      borderRadius: 50,
                      withBorder: 1,
                      type: IZIButtonType.OUTLINE,
                    ),
                  ),
                SizedBox(
                  width: IZIDimensions.SPACE_SIZE_4X,
                ),
                if (!IZIValidate.nullOrEmpty(onTapConfirm))
                  Expanded(
                    child: IZIButton(
                      onTap: () {
                        onTapConfirm!();
                      },
                      label: 'ĐỒNG Ý',
                      fontSizedLabel: IZIDimensions.FONT_SIZE_SPAN,
                      padding: EdgeInsets.all(
                        IZIDimensions.SPACE_SIZE_2X,
                      ),
                      borderRadius: 50,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DialogShowInformation extends StatelessWidget {
  final double rotateAngle;
  final IconData? icon;
  final String title;
  final Color? color;
  final Widget? content;
  final Function()? onTapConfirm;
  final Function()? onTapCancle;
  final String? cancleLabel;
  final String? confirmLabel;
  const DialogShowInformation({
    this.rotateAngle = 0,
    this.icon,
    required this.title,
    this.color,
    this.content,
    this.onTapConfirm,
    this.onTapCancle,
    this.cancleLabel,
    this.confirmLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_5X,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_3X,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_4X,
          vertical: IZIDimensions.SPACE_SIZE_4X,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorResources.PRIMARY_1,
                      fontSize: IZIDimensions.FONT_SIZE_H4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                  color: ColorResources.NEUTRALS_6,
                )
              ],
            ),
            SizedBox(
              height: IZIDimensions.SPACE_SIZE_2X,
            ),
            if (content != null) content!,
            SizedBox(
              height: IZIDimensions.iziSize.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!IZIValidate.nullOrEmpty(onTapCancle))
                  Expanded(
                    child: IZIButton(
                      colorBG: ColorResources.WHITE,
                      colorText: ColorResources.PRIMARY_4,
                      onTap: () {
                        onTapCancle!();
                      },
                      label: cancleLabel ?? 'NO',
                      fontSizedLabel: IZIDimensions.FONT_SIZE_SPAN,
                      padding: EdgeInsets.all(
                        IZIDimensions.ONE_UNIT_SIZE * 14,
                      ),
                      borderRadius: 50,
                      withBorder: 1,
                      type: IZIButtonType.OUTLINE,
                    ),
                  ),
                SizedBox(
                  width: IZIDimensions.SPACE_SIZE_4X,
                ),
                if (!IZIValidate.nullOrEmpty(onTapConfirm))
                  Expanded(
                    child: IZIButton(
                      onTap: () {
                        onTapConfirm!();
                      },
                      label: confirmLabel ?? 'YES',
                      fontSizedLabel: IZIDimensions.FONT_SIZE_SPAN,
                      padding: EdgeInsets.all(
                        IZIDimensions.SPACE_SIZE_2X,
                      ),
                      borderRadius: 50,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DialogTablet extends StatelessWidget {
  final double rotateAngle;
  final IconData? icon;
  final String? imagesIcon;
  final String description;
  final Color? color;
  final Function()? onTapConfirm;
  final Function()? onTapCancle;
  const DialogTablet({
    this.rotateAngle = 0,
    this.icon,
    required this.description,
    this.imagesIcon,
    this.color,
    this.onTapConfirm,
    this.onTapCancle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.iziSize.width * 0.15,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_3X,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.iziSize.width * 0.1,
          vertical: IZIDimensions.SPACE_SIZE_4X * 2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                if (imagesIcon != null)
                  AvatarGlow(
                    glowColor: ColorResources.COLOR_DIALOG,
                    duration: const Duration(milliseconds: 1500),
                    endRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
                    child: Container(
                      padding: EdgeInsets.all(
                        IZIDimensions.SPACE_SIZE_2X,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.COLOR_DIALOG.withOpacity(.15),
                      ),
                      child: IZIImage(
                        imagesIcon.toString(),
                        fit: BoxFit.contain,
                        width: IZIDimensions.ONE_UNIT_SIZE * 100,
                        height: IZIDimensions.ONE_UNIT_SIZE * 100,
                      ),
                    ),
                  )
                else
                  AvatarGlow(
                    glowColor: ColorResources.COLOR_DIALOG,
                    duration: const Duration(milliseconds: 1500),
                    endRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
                    child: Container(
                      padding: EdgeInsets.all(
                        IZIDimensions.SPACE_SIZE_2X,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.COLOR_DIALOG.withOpacity(.15),
                      ),
                      child: Icon(
                        icon ?? Icons.check,
                        size: IZIDimensions.ONE_UNIT_SIZE * 100,
                        color: color ?? ColorResources.GREEN,
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(
              height: IZIDimensions.SPACE_SIZE_5X,
            ),
            Padding(
              padding: EdgeInsets.only(
                right: IZIDimensions.SPACE_SIZE_3X,
              ),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontSize: IZIDimensions.FONT_SIZE_H2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: IZIDimensions.SPACE_SIZE_5X * 1.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!IZIValidate.nullOrEmpty(onTapCancle))
                  Expanded(
                    child: IZIButton(
                      colorBG: ColorResources.WHITE,
                      colorText: ColorResources.PRIMARY_4,
                      onTap: () {
                        onTapCancle!();
                      },
                      label: 'NO',
                      fontSizedLabel: IZIDimensions.FONT_SIZE_SPAN,
                      padding: EdgeInsets.all(
                        IZIDimensions.ONE_UNIT_SIZE * 30,
                      ),
                      borderRadius: 50,
                      withBorder: 1,
                      type: IZIButtonType.OUTLINE,
                    ),
                  ),
                SizedBox(
                  width: IZIDimensions.SPACE_SIZE_4X,
                ),
                if (!IZIValidate.nullOrEmpty(onTapConfirm))
                  Expanded(
                    child: IZIButton(
                      onTap: () {
                        onTapConfirm!();
                      },
                      label: 'YES',
                      fontSizedLabel: IZIDimensions.FONT_SIZE_SPAN,
                      padding: EdgeInsets.all(
                        IZIDimensions.ONE_UNIT_SIZE * 30,
                      ),
                      borderRadius: 50,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
