import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/izi_loading_card.dart';
import 'package:fooding_project/base_widget/izi_smart_refresher.dart';
import 'package:fooding_project/base_widget/p45_appbar.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/screens/feel_rating/feel_rating_cotroller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';

class FeelRatingPage extends GetView<FeelRatingController> {
  const FeelRatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FeelRatingController(),
      builder: (FeelRatingController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          appBar: const P45AppBarP(title: 'Danh sách đơn hàng'),
          body: controller.isLoading == true
              ? const CardLoadingItem(count: 10)
              : controller.listOrder.isEmpty
                  ? const DataEmpty()
                  : Container(
                      padding: EdgeInsets.symmetric(
                          vertical: IZIDimensions.ONE_UNIT_SIZE * 20),
                      child: IZISmartRefresher(
                        refreshController: controller.refreshController,
                        onRefresh: () {
                          controller.getAllOrder();
                        },
                        onLoading: () {},
                        enablePullDown: true,
                        child: ListView.builder(
                          itemCount: controller.listOrder.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print('vanvanphuong');
                                print(controller.listOrder[index].id!);
                                controller.gotoReviewFood(controller.listOrder[index].id!);
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
                                padding:
                                    EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    IZIDimensions.BORDER_RADIUS_4X,
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    //   controller.gotoDetailOrder(index);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            controller.listOrder[index]
                                                    .listProduct!.isEmpty
                                                ? "Không xác định"
                                                : controller
                                                    .userResponse.fullName!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: NUNITO,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6 *
                                                      0.95,
                                            ),
                                          ),
                                          const Spacer(),
                                          const Text(
                                            'Hoàn thành',
                                            style: TextStyle(
                                              color: ColorResources.RED,
                                            ),
                                          ),
                                          SizedBox(
                                            width: IZIDimensions.SPACE_SIZE_2X,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: IZIDimensions.SPACE_SIZE_2X,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: IZIDimensions.SPACE_SIZE_5X,
                                        ),
                                        child: const Divider(
                                          height: 2,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            IZIDimensions.iziSize.height * 0.13,
                                        width: IZIDimensions.iziSize.width,
                                        child: ListView.builder(
                                          itemCount: controller.listOrder[index]
                                              .listProduct!.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, indexFood) {
                                            final item = controller
                                                .listOrder[index]
                                                .listProduct![indexFood];
                                            return GestureDetector(
                                              onTap: () {
                                                     controller.gotoReviewFood(controller.listOrder[index].id!);
                                              },
                                              child: Container(
                                                height:
                                                    IZIDimensions.iziSize.height *
                                                        0.13,
                                                width: IZIDimensions.iziSize.width *
                                                    0.8,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      IZIDimensions.SPACE_SIZE_2X,
                                                ),
                                                margin: EdgeInsets.only(
                                                  top: IZIDimensions.SPACE_SIZE_1X,
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            IZIDimensions
                                                                .BORDER_RADIUS_3X),
                                                    color: ColorResources.WHITE),
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .circular(IZIDimensions
                                                              .BORDER_RADIUS_3X),
                                                      child: IZIImage(
                                                        IZIValidate.nullOrEmpty(
                                                                item.image)
                                                            ? ImagesPath.placeHolder
                                                            : item.image!.first,
                                                        height: IZIDimensions
                                                                .ONE_UNIT_SIZE *
                                                            120,
                                                        width: IZIDimensions
                                                                .ONE_UNIT_SIZE *
                                                            120,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: IZIDimensions
                                                          .SPACE_SIZE_1X,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                IZIValidate
                                                                        .nullOrEmpty(
                                                                            item.name)
                                                                    ? "không xác định"
                                                                    : item.name!,
                                                                style: TextStyle(
                                                                  color:
                                                                      ColorResources
                                                                          .colorMain,
                                                                  fontFamily:
                                                                      NUNITO,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontSize:
                                                                      IZIDimensions
                                                                          .FONT_SIZE_H6,
                                                                ),
                                                              ),
                                                              //
                                                            ],
                                                          ),
                                                          Text(
                                                            "Số lượng : ${IZIValidate.nullOrEmpty(item.quantity) ? "không xác định" : item.quantity!}",
                                                            style: TextStyle(
                                                              color: ColorResources
                                                                  .GREY,
                                                              fontFamily: NUNITO,
                                                              fontWeight:
                                                                  FontWeight.w400,
                                                              fontSize: IZIDimensions
                                                                  .FONT_SIZE_DEFAULT,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Giá tiền : ",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          ColorResources
                                                                              .GREY,
                                                                      fontFamily:
                                                                          NUNITO,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          IZIDimensions
                                                                              .FONT_SIZE_DEFAULT,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    IZIValidate.nullOrEmpty(
                                                                            item
                                                                                .price)
                                                                        ? "không xác định"
                                                                        : IZIPrice.currencyConverterVND(item
                                                                            .price!
                                                                            .toDouble()),
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          ColorResources
                                                                              .GREY,
                                                                      fontFamily:
                                                                          NUNITO,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      decoration: item
                                                                                  .priceDiscount !=
                                                                              0
                                                                          ? TextDecoration
                                                                              .lineThrough
                                                                          : null,
                                                                      fontSize:
                                                                          IZIDimensions
                                                                              .FONT_SIZE_DEFAULT,
                                                                    ),
                                                                  ),
                                                                  item.priceDiscount !=
                                                                          0
                                                                      ? Text(
                                                                          IZIPrice.currencyConverterVND(item
                                                                              .priceDiscount!
                                                                              .toDouble()),
                                                                          style:
                                                                              TextStyle(
                                                                            color: ColorResources
                                                                                .GREY,
                                                                            fontFamily:
                                                                                NUNITO,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize:
                                                                                IZIDimensions.FONT_SIZE_DEFAULT,
                                                                          ),
                                                                        )
                                                                      : const SizedBox(),
                                                                  Text(
                                                                    "đ",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          ColorResources
                                                                              .GREY,
                                                                      fontFamily:
                                                                          NUNITO,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          IZIDimensions
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
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: IZIDimensions.SPACE_SIZE_5X,
                                        ),
                                        child: const Divider(
                                          height: 2,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height: IZIDimensions.SPACE_SIZE_1X,
                                      ),
                                       Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Tạm tính : ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6,
                                              color: ColorResources.RED,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                          IZIPrice.currencyConverterVND(
                                                    controller.tinhTamTinh(controller.listOrder[index].listProduct!)),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6,
                                              color: ColorResources.RED,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: IZIDimensions.SPACE_SIZE_1X*0.5,),
                                       Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Phí ship : ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6,
                                              color: ColorResources.RED,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            IZIValidate.nullOrEmpty(controller
                                                    .listOrder[index].shipPrice)
                                                ? "không xác định"
                                                : IZIPrice.currencyConverterVND(
                                                    controller.listOrder[index]
                                                        .shipPrice!),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6,
                                              color: ColorResources.RED,
                                            ),
                                          ),
                                        ],
                                      ),
                                          SizedBox(height: IZIDimensions.SPACE_SIZE_1X*0.5,),
                                       Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Vourcher : ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6,
                                              color: ColorResources.RED,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                         IZIPrice.currencyConverterVND(
                                                    controller.tinhVoucher
                                                    ( controller.tinhTamTinh(controller.listOrder[index].listProduct!), 
                                                    controller.listOrder[index].shipPrice!,   controller.listOrder[index].totalPrice!)),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6,
                                              color: ColorResources.RED,
                                            ),
                                          ),
                                        ],
                                      ),
                                          SizedBox(height: IZIDimensions.SPACE_SIZE_1X*0.5,),                                  
                                     const Divider(),  
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Tổng đơn",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6,
                                              color: ColorResources.RED,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            IZIValidate.nullOrEmpty(controller
                                                    .listOrder[index].totalPrice)
                                                ? "không xác định"
                                                : IZIPrice.currencyConverterVND(
                                                    controller.listOrder[index]
                                                        .totalPrice!),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6,
                                              color: ColorResources.RED,
                                            ),
                                          ),
                                        ],
                                      ),
                                         SizedBox(height: IZIDimensions.SPACE_SIZE_1X*0.5,),    
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
