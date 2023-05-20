// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/p45_appbar.dart';
import 'package:fooding_project/base_widget/p45_button.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/screens/rate/rate_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class RatePage extends GetView<RateController> {
  const RatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: RateController(),
      builder: (RateController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          appBar: P45AppBarP(
            title: controller.arguments[1] == CANCEL
                ? 'Hủy đơn hàng'
                : "Xác nhận giao hàng thành công",
          ),
          floatingActionButton: P45Button(
            title: controller.arguments[1] == CANCEL
                ? 'Hủy đơn hàng'
                : 'Thành công',
            onPressed: () {
              controller.onClickHandle();
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Column(
            children: [
              // evaluate
              Expanded(
                child: Container(
                  height: IZIDimensions.iziSize.height,
                  width: IZIDimensions.iziSize.width,
                  padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
                  color: ColorResources.WHITE,
                  child: Column(
                    children: [
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      _textFiled(controller),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin:
                            EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_2X),
                        padding:
                            EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_2X),
                        child: Row(
                          children: [
                            // pick image
                            GestureDetector(
                              onTap: () {
                                controller.pickAvatar();
                              },
                              child: Container(
                                height: IZIDimensions.ONE_UNIT_SIZE * 150,
                                width: IZIDimensions.ONE_UNIT_SIZE * 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      IZIDimensions.SPACE_SIZE_3X),
                                  color: ColorResources.GREY.withOpacity(0.1),
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.add_a_photo,
                                  size: IZIDimensions.ONE_UNIT_SIZE * 50,
                                  color: ColorResources.GREY,
                                )),
                              ),
                            ),
                            SizedBox(
                              width: IZIDimensions.SPACE_SIZE_1X,
                            ),

                            //  show imager picker
                            _showImagePicker(controller),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_4X,
                      ),
                      const Divider(),
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      Text(
                        'Hãy chụp ảnh và lý do hủy đơn hàng, bạn muốn hủy đơn hàng hãy thống nhất với khách hàng. Bất kì sai phạm nào bạn sẽ bị khóa tài khoản vĩnh viễn',
                        maxLines: 5,
                        style: TextStyle(
                          color: ColorResources.GREY,
                          fontFamily: NUNITO,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///
  /// show image picker
  ///
  Widget _showImagePicker(RateController controller) {
    return Stack(
      children: [
        Container(
          height: IZIDimensions.ONE_UNIT_SIZE * 150,
          width: IZIDimensions.ONE_UNIT_SIZE * 150,
          decoration: BoxDecoration(
            border: Border.all(
                color: ColorResources.GREY.withOpacity(0.5),
                width: 1,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(IZIDimensions.SPACE_SIZE_3X),
          ),
          child: IZIValidate.nullOrEmpty(controller.listImageFile)
              ? Container()
              : ClipRRect(
                  borderRadius:
                      BorderRadius.circular(IZIDimensions.SPACE_SIZE_3X),
                  child: IZIImage.file(controller.listImageFile.first)),
        ),
        Positioned(
          bottom: 0,
          right: 5,
          child: Visibility(
            visible: controller.listImageFile.length > 1 ? true : false,
            child: Text(
              '+${controller.listImageFile.length - 1}',
              maxLines: 1,
              style: TextStyle(
                color: ColorResources.WHITE,
                fontFamily: NUNITO,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
                fontSize: IZIDimensions.FONT_SIZE_H4,
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///
  /// text field evaluat
  ///

  Container _textFiled(RateController controller) {
    return Container(
      color: ColorResources.WHITE,
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_4X,
        horizontal: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: TextField(
        keyboardType: TextInputType.multiline,
        controller: controller.editingController,
        onChanged: (val) {},
        decoration: InputDecoration(
          hintText: 'Lý do',
          hintStyle: TextStyle(color: ColorResources.GREY.withOpacity(1)),
          contentPadding: EdgeInsets.symmetric(
              vertical: IZIDimensions.ONE_UNIT_SIZE * 50,
              horizontal: IZIDimensions.ONE_UNIT_SIZE * 50),
          fillColor: ColorResources.GREY.withOpacity(0.1),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_5X),
          ),
        ),
      ),
    );
  }
}
