// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/p45_appbar.dart';
import 'package:fooding_project/base_widget/p45_button.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/screens/evaluate/evaluate_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class EvaluatePage extends GetView<EvaluateController> {
  const EvaluatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: EvaluateController(),
      builder: (EvaluateController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          appBar:  P45AppBarP(
            title:   controller.type=='PRODUCT' ?'Đánh giá sản phẩm' : 'Đánh giá tài xế',
            ),
          floatingActionButton: P45Button(
            title: 'Gửi đánh giá',
            onPressed: () {
              controller.postComment(controller.type);
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: controller.isLoadingOrder == false
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    // listview product order
                    // check
                   controller.type=='PRODUCT' ? 
                    _listViewProductOrder() : _viewShipper(controller),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    // evaluate
                    Expanded(
                      child: SingleChildScrollView(
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
                              RatingStars(
                                value: controller.countRating.toDouble(),
                                starCount: 5,
                                starSpacing: 4,
                                starSize: IZIDimensions.ONE_UNIT_SIZE * 50,
                                starColor: Colors.yellow,
                                valueLabelVisibility: false,
                                onValueChanged: (value) {
                                  controller.clickRatingBar(value);
                                  print(value);
                                },
                              ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_3X,
                              ),
                              //
                                    
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.clickSatisField();
                                    },
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.thumb_up,
                                          color: controller.satisFied
                                              ? Colors.blue
                                              : ColorResources.GREY,
                                          size: IZIDimensions.ONE_UNIT_SIZE * 45,
                                        ),
                                        Text(
                                          'Hài lòng',
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: ColorResources.GREY,
                                            fontFamily: NUNITO,
                                            fontWeight: FontWeight.w600,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: IZIDimensions.FONT_SIZE_H6,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.clickSatisField();
                                    },
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.thumb_down,
                                          color: controller.satisFied
                                              ? Colors.grey
                                              : Colors.blue,
                                          size: IZIDimensions.ONE_UNIT_SIZE * 45,
                                        ),
                                        Text(
                                          'Không hài lòng',
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: ColorResources.GREY,
                                            fontFamily: NUNITO,
                                            fontWeight: FontWeight.w600,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: IZIDimensions.FONT_SIZE_H6,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                              //
                              ,
                              _textFiled(controller),
                                    
                              Visibility(
                                visible: controller.type=='PRODUCT'?true:false,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(
                                      top: IZIDimensions.SPACE_SIZE_2X),
                                  padding: EdgeInsets.only(
                                      left: IZIDimensions.SPACE_SIZE_2X),
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
                                            color: ColorResources.GREY
                                                .withOpacity(0.1),
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
                              ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_4X,
                              ),
                              const Divider(),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              Text(
                                'Chia sẻ cảm nhận, đánh giá để cửa hàng chúng tôi ngày càng hoàn thiện hơn. \nRất cảm ơn quý khách hàng đã lựa chọn cửa hàng chúng tôi trong hàng ngàn cửa hàng ngoài kia',
                                maxLines: 2,
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
  Widget _showImagePicker(EvaluateController controller) {
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
  /// listview product order
  ///
  Widget _listViewProductOrder() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.orderResponse!.listProduct!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
          color: ColorResources.WHITE,
          padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(IZIDimensions.SPACE_SIZE_2X),
                    child: IZIImage(
                      controller
                          .orderResponse!.listProduct![index].image!.first,
                      height: IZIDimensions.ONE_UNIT_SIZE * 150,
                      width: IZIDimensions.ONE_UNIT_SIZE * 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.orderResponse!.listProduct![index].name!,
                          style: TextStyle(
                            color: ColorResources.BLACK,
                            fontFamily: NUNITO,
                            fontWeight: FontWeight.w600,
                            fontSize: IZIDimensions.FONT_SIZE_H5,
                          ),
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        Text(
                          'x${controller.orderResponse!.listProduct![index].quantity!}',
                          style: TextStyle(
                            color: ColorResources.GREY,
                            fontFamily: NUNITO,
                            fontWeight: FontWeight.w600,
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                          ),
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        Text(
                          controller.orderResponse!.listProduct![index]
                                      .priceDiscount ==
                                  0
                              ? '${IZIPrice.currencyConverterVND(controller.orderResponse!.listProduct![index].price!.toDouble())}đ'
                              : '${IZIPrice.currencyConverterVND(controller.orderResponse!.listProduct![index].priceDiscount!.toDouble())}đ',
                          style: TextStyle(
                            color: ColorResources.colorMain,
                            fontFamily: NUNITO,
                            fontWeight: FontWeight.w600,
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

///
/// text field evaluat
///

Container _textFiled(EvaluateController controller) {
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
        hintText: 'Đánh giá của bạn',
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

///
/// shipper
///
Widget _viewShipper(EvaluateController controller) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: IZIDimensions.SPACE_SIZE_2X,
    ),
    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(IZIDimensions.SPACE_SIZE_2X),
      color: ColorResources.WHITE,
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
          child: IZIImage(
            IZIValidate.nullOrEmpty(controller.userResponse.avatar)
                ? 'https://thichtours.com/wp-content/uploads/2020/08/IMG_9830-copy-550x500.jpg'
                : controller.userResponse.avatar!,
            height: IZIDimensions.ONE_UNIT_SIZE * 120,
            width: IZIDimensions.ONE_UNIT_SIZE * 120,
          ),
        ),
        SizedBox(
          width: IZIDimensions.SPACE_SIZE_1X,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                IZIValidate.nullOrEmpty(controller.userResponse.fullName)
                    ? ''
                    : controller.userResponse.fullName!,
                style: TextStyle(
                  color: ColorResources.colorMain,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                ),
              ),
              Text(
                IZIValidate.nullOrEmpty(controller.userResponse.phone)
                    ? ''
                    : controller.userResponse.phone!,
                style: TextStyle(
                  color: ColorResources.GREY,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w400,
                  fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                ),
              ),
              Text(
                IZIValidate.nullOrEmpty(controller.userResponse.idVehicle)
                    ? ''
                    : "Biển số xe : ${controller.userResponse.idVehicle}",
                style: TextStyle(
                  color: ColorResources.GREY,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w400,
                  fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
