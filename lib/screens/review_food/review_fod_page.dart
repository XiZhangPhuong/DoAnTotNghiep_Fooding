import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/izi_loading_card.dart';
import 'package:fooding_project/base_widget/p45_appbar.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/screens/review_food/review_food_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';

class ReviewFoodPage extends GetView<ReviewFoodController> {
  const ReviewFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ReviewFoodController(),
      builder: (ReviewFoodController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          appBar: const P45AppBarP(title: 'Đánh giá đơn hàng'),
          body: controller.isLoading == false
              ? const CardLoadingItem(
                  count: 10,
                )
              : Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,                 
                      itemCount: controller.orderResponse.listProduct!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, indexFood) {
                        final item =
                            controller.orderResponse.listProduct![indexFood];
                        return GestureDetector(
                          onTap: () {
                            //  controller.gotoReviewFood(controller.orderReponse.id!);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  IZIDimensions.SPACE_SIZE_2X),
                              color: ColorResources.WHITE,
                            ),
                            child: Row(
                             
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      IZIDimensions.BORDER_RADIUS_3X),
                                  child: IZIImage(
                                    IZIValidate.nullOrEmpty(item.image)
                                        ? ImagesPath.placeHolder
                                        : item.image!.first,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            IZIValidate.nullOrEmpty(item.name)
                                                ? "không xác định"
                                                : item.name!,
                                            style: TextStyle(
                                              color: ColorResources.colorMain,
                                              fontFamily: NUNITO,
                                              fontWeight: FontWeight.w600,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6,
                                            ),
                                          ),
                                          //
                                         GestureDetector(
                                          onTap: () {
                                            controller.gotoEvaluateProduct(controller.orderResponse.id!,item.id!,'');
                                          },
                                           child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: IZIDimensions.SPACE_SIZE_3X,
                                              vertical: IZIDimensions.SPACE_SIZE_1X,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(IZIDimensions.SPACE_SIZE_1X),
                                              color: ColorResources.colorMain
                                            ),
                                             child: Text(
                                                 'Đánh giá',
                                                style: TextStyle(
                                                  color: ColorResources.WHITE,
                                                  fontFamily: NUNITO,
                                                  fontWeight: FontWeight.w600,
                                                  overflow: TextOverflow.ellipsis,
                                                  decoration: controller.checkOrder[indexFood]==true ? 
                                                  TextDecoration.lineThrough : TextDecoration.none,
                                                  fontSize:
                                                      IZIDimensions.FONT_SIZE_H6,
                                                ),
                                              ),
                                           ),
                                         ), 
                                        ],
                                      ),
                                      Text(
                                        "Số lượng : ${IZIValidate.nullOrEmpty(item.quantity) ? "không xác định" : item.quantity!}",
                                        style: TextStyle(
                                          color: ColorResources.GREY,
                                          fontFamily: NUNITO,
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              IZIDimensions.FONT_SIZE_DEFAULT,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Giá tiền : ",
                                                style: TextStyle(
                                                  color: ColorResources.GREY,
                                                  fontFamily: NUNITO,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: IZIDimensions
                                                      .FONT_SIZE_DEFAULT,
                                                ),
                                              ),
                                              Text(
                                                IZIValidate.nullOrEmpty(
                                                        item.price)
                                                    ? "không xác định"
                                                    : IZIPrice
                                                        .currencyConverterVND(item
                                                            .price!
                                                            .toDouble()),
                                                style: TextStyle(
                                                  color: ColorResources.GREY,
                                                  fontFamily: NUNITO,
                                                  fontWeight: FontWeight.w400,
                                                  decoration:
                                                      item.priceDiscount != 0
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : null,
                                                  fontSize: IZIDimensions
                                                      .FONT_SIZE_DEFAULT,
                                                ),
                                              ),
                                              item.priceDiscount != 0
                                                  ? Text(
                                                      IZIPrice
                                                          .currencyConverterVND(
                                                              item.priceDiscount!
                                                                  .toDouble()),
                                                      style: TextStyle(
                                                        color:
                                                            ColorResources.GREY,
                                                        fontFamily: NUNITO,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: IZIDimensions
                                                            .FONT_SIZE_DEFAULT,
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                              Text(
                                                "đ",
                                                style: TextStyle(
                                                  color: ColorResources.GREY,
                                                  fontFamily: NUNITO,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: IZIDimensions
                                                      .FONT_SIZE_DEFAULT,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: IZIDimensions.SPACE_SIZE_2X,),
                  Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  IZIDimensions.SPACE_SIZE_2X),
                              color: ColorResources.WHITE,
                            ),
                            child: Row(
                             
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      IZIDimensions.BORDER_RADIUS_3X),
                                  child: IZIImage(
                                    IZIValidate.nullOrEmpty(controller.userResponse.avatar) ?
                                    ''  : controller.userResponse.avatar!,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                          IZIValidate.nullOrEmpty(controller.userResponse.fullName) ?'':
                                          controller.userResponse.fullName!
                                          ,
                                            style: TextStyle(
                                              color: ColorResources.colorMain,
                                              fontFamily: NUNITO,
                                              fontWeight: FontWeight.w600,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6,
                                            ),
                                          ),
                                           GestureDetector(
                                          onTap: () {
                                           controller.gotoEvaluateProduct(controller.orderResponse.id!,'',controller.orderResponse.idEmployee!);  
                                          },
                                           child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: IZIDimensions.SPACE_SIZE_3X,
                                              vertical: IZIDimensions.SPACE_SIZE_1X,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(IZIDimensions.SPACE_SIZE_1X),
                                              color: ColorResources.colorMain
                                            ),
                                             child: Text(
                                                 'Đánh giá',
                                                style: TextStyle(
                                                  color: ColorResources.WHITE,
                                                  fontFamily: NUNITO,
                                                  fontWeight: FontWeight.w600,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize:
                                                      IZIDimensions.FONT_SIZE_H6,
                                                ),
                                              ),
                                           ),
                                         ), 
                                        ],
                                      ),
                                      Text(
                                        IZIValidate.nullOrEmpty(controller.userResponse.phone) ?'':
                                      controller.userResponse.phone!,
                                        style: TextStyle(
                                          color: ColorResources.GREY,
                                          fontFamily: NUNITO,
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              IZIDimensions.FONT_SIZE_DEFAULT,
                                        ),
                                      ),
                                       Text(
                                        IZIValidate.nullOrEmpty(controller.userResponse.idVehicle) ? '' :
                                                "Biển số xe : ${controller.userResponse.idVehicle}",
                                                style: TextStyle(
                                                  color: ColorResources.GREY,
                                                  fontFamily: NUNITO,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: IZIDimensions
                                                      .FONT_SIZE_DEFAULT,
                                                ),
                                              ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                ],
              ),
        );
      },
    );
  }
}
