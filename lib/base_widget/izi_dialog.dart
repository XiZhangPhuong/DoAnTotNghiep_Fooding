import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/izi_dimensions.dart';
import '../helper/izi_validate.dart';
import '../utils/color_resources.dart';
import 'izi_button.dart';
import 'izi_text.dart';


// ignore: avoid_classes_with_only_static_members
class IZIDialog {
  static Future<void> showDialog(
      {required String lable,
      String? confirmLabel,
      String? cancelLabel,
      String? description,
      final Color? color,
      Function? onConfirm,
      Function? onCancel}) {
    return Get.defaultDialog(
      titlePadding: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_5X,
        left: IZIDimensions.SPACE_SIZE_2X,
        right: IZIDimensions.SPACE_SIZE_2X,
        bottom: IZIDimensions.SPACE_SIZE_1X,
      ),
      barrierDismissible: false,
      title: lable,
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_1X * 3,
            ),
            child: IZIText(
              textAlign: TextAlign.center,
              text: description ?? '',
              maxLine: 7,
              style: TextStyle(fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL * 1.2, fontWeight: FontWeight.w600, color: color),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_1X),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  fit: FlexFit.tight,
                  child: SizedBox(),
                ),
                if (!IZIValidate.nullOrEmpty(onCancel))
                  IZIButton(
                    colorBG: ColorResources.WHITE,
                    withBorder: 1,
                    margin: const EdgeInsets.all(0),
                    type: IZIButtonType.OUTLINE,
                    colorText: ColorResources.PRIMARY_1,
                    label: cancelLabel ?? "Không",
                    borderRadius: IZIDimensions.BORDER_RADIUS_7X,
                    width: IZIDimensions.iziSize.width * 0.30,
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.ONE_UNIT_SIZE * 15,
                      vertical: IZIDimensions.ONE_UNIT_SIZE * 15,
                    ),
                    colorBorder: ColorResources.PRIMARY_1,
                    onTap: () {
                      onCancel!();
                    },
                  ),
                const Flexible(
                  fit: FlexFit.tight,
                  child: SizedBox(),
                ),
                SizedBox(
                  width: IZIDimensions.SPACE_SIZE_1X,
                ),
                const Flexible(
                  fit: FlexFit.tight,
                  child: SizedBox(),
                ),
                if (!IZIValidate.nullOrEmpty(onConfirm))
                  IZIButton(
                    withBorder: 1,
                    margin: const EdgeInsets.all(0),
                    borderRadius: IZIDimensions.BORDER_RADIUS_7X,
                    width: IZIDimensions.iziSize.width * 0.35,
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.ONE_UNIT_SIZE * 15,
                      vertical: IZIDimensions.ONE_UNIT_SIZE * 20,
                    ),
                    label: confirmLabel ?? "Đồng ý",
                    onTap: () {
                      onConfirm!();
                    },
                  ),
                const Flexible(
                  fit: FlexFit.tight,
                  child: SizedBox(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
