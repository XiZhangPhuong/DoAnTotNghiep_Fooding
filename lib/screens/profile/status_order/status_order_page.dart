import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_smart_refresher.dart';
import 'package:fooding_project/base_widget/izi_tabbar.dart';
import 'package:fooding_project/base_widget/p45_appbar.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/screens/profile/status_order/status_order_controller.dart';
import 'package:fooding_project/screens/widgets/app_bar.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:get/get.dart';

import '../../../base_widget/izi_image.dart';
import '../../../helper/izi_validate.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/images_path.dart';

class StatusOrderPage extends GetView {
  const StatusOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const P45AppBarP(title: 'Trạng thái đơn hàng'),
      body: GetBuilder(
        init: StatusOrderController(),
        builder: (controller) => controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  IZITabBar(
                    currentIndex: controller.choiceItem,
                    colorUnderLine: const Color(0xffF8775C),
                    items: controller.timeList1,
                    onTapChangedTabbar: (val) {
                      controller.onChoiceItem(val);
                    },
                    colorText: const Color(0xffF8775C),
                    disbleColorText: ColorResources.BLACK,
                  ),
                  controller.isLoadingChangeTab
                      ? SizedBox(
                          height: IZIDimensions.iziSize.height * 0.8,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Expanded(
                          child: controller.listOrder.isEmpty
                              ? IZIImage(
                                  ImagesPath.emptyCart,
                                  fit: BoxFit.contain,
                                )
                              : IZISmartRefresher(
                                  refreshController:
                                      controller.refreshController,
                                  onRefresh: () {
                                    controller.getAllOrder();
                                  },
                                  onLoading: () {},
                                  enablePullUp: true,
                                  enablePullDown: true,
                                  child: ListView.builder(
                                    itemCount: controller.listOrder.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.all(
                                            IZIDimensions.SPACE_SIZE_1X),
                                        padding: EdgeInsets.all(
                                            IZIDimensions.SPACE_SIZE_1X),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            IZIDimensions.BORDER_RADIUS_4X,
                                          ),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.gotoDetailOrder(index);
                                          },
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    controller
                                                            .listOrder[index]
                                                            .listProduct!
                                                            .isEmpty
                                                        ? "Không xác định"
                                                        : IZIValidate.nullOrEmpty(
                                                                controller
                                                                    .userResponse
                                                                    .fullName)
                                                            ? ""
                                                            : controller
                                                                .userResponse
                                                                .fullName!,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: NUNITO,
                                                      fontSize: IZIDimensions
                                                              .FONT_SIZE_H6 *
                                                          0.95,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    IZIValidate.nullOrEmpty(
                                                            controller
                                                                .listOrder[
                                                                    index]
                                                                .statusOrder)
                                                        ? "Không xác định"
                                                        : controller
                                                            .formatStatuString(
                                                                controller
                                                                    .listOrder[
                                                                        index]
                                                                    .statusOrder!),
                                                    style: const TextStyle(
                                                      color: ColorResources.RED,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: IZIDimensions
                                                        .SPACE_SIZE_2X,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    IZIDimensions.SPACE_SIZE_2X,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: IZIDimensions
                                                      .SPACE_SIZE_5X,
                                                ),
                                                child: const Divider(
                                                  height: 2,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                height: IZIDimensions
                                                        .iziSize.height *
                                                    0.13,
                                                width:
                                                    IZIDimensions.iziSize.width,
                                                child: ListView.builder(
                                                  itemCount: controller
                                                      .listOrder[index]
                                                      .listProduct!
                                                      .length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, indexFood) {
                                                    final item = controller
                                                            .listOrder[index]
                                                            .listProduct![
                                                        indexFood];
                                                    return Container(
                                                      height: IZIDimensions
                                                              .iziSize.height *
                                                          0.13,
                                                      width: IZIDimensions
                                                              .iziSize.width *
                                                          0.8,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            IZIDimensions
                                                                .SPACE_SIZE_2X,
                                                      ),
                                                      margin: EdgeInsets.only(
                                                        top: IZIDimensions
                                                            .SPACE_SIZE_1X,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  IZIDimensions
                                                                      .BORDER_RADIUS_3X),
                                                          color: ColorResources
                                                              .WHITE),
                                                      child: Row(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    IZIDimensions
                                                                        .BORDER_RADIUS_3X),
                                                            child: IZIImage(
                                                              IZIValidate.nullOrEmpty(
                                                                      item
                                                                          .image)
                                                                  ? ImagesPath
                                                                      .placeHolder
                                                                  : item.image!
                                                                      .first,
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
                                                                Text(
                                                                  IZIValidate.nullOrEmpty(item
                                                                          .name)
                                                                      ? "không xác định"
                                                                      : item
                                                                          .name!,
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorResources
                                                                        .colorMain,
                                                                    fontFamily:
                                                                        NUNITO,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        IZIDimensions
                                                                            .FONT_SIZE_H6,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "Số lượng : ${IZIValidate.nullOrEmpty(item.quantity) ? "không xác định" : item.quantity!}",
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
                                                                Row(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Giá tiền : ",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ColorResources.GREY,
                                                                            fontFamily:
                                                                                NUNITO,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize:
                                                                                IZIDimensions.FONT_SIZE_DEFAULT,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          IZIValidate.nullOrEmpty(item.price)
                                                                              ? "không xác định"
                                                                              : IZIPrice.currencyConverterVND(item.price!.toDouble()),
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ColorResources.GREY,
                                                                            fontFamily:
                                                                                NUNITO,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            decoration: item.priceDiscount != 0
                                                                                ? TextDecoration.lineThrough
                                                                                : null,
                                                                            fontSize:
                                                                                IZIDimensions.FONT_SIZE_DEFAULT,
                                                                          ),
                                                                        ),
                                                                        item.priceDiscount !=
                                                                                0
                                                                            ? Text(
                                                                                IZIPrice.currencyConverterVND(item.priceDiscount!.toDouble()),
                                                                                style: TextStyle(
                                                                                  color: ColorResources.GREY,
                                                                                  fontFamily: NUNITO,
                                                                                  fontWeight: FontWeight.w400,
                                                                                  fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                                                                                ),
                                                                              )
                                                                            : const SizedBox(),
                                                                        Text(
                                                                          "vnđ",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ColorResources.GREY,
                                                                            fontFamily:
                                                                                NUNITO,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize:
                                                                                IZIDimensions.FONT_SIZE_DEFAULT,
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
                                                    );
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: IZIDimensions
                                                      .SPACE_SIZE_5X,
                                                ),
                                                child: const Divider(
                                                  height: 2,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    IZIDimensions.SPACE_SIZE_1X,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Tổng đơn",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: IZIDimensions
                                                          .FONT_SIZE_H6,
                                                      color: ColorResources.RED,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    IZIValidate.nullOrEmpty(
                                                            controller
                                                                .listOrder[
                                                                    index]
                                                                .totalPrice)
                                                        ? "không xác định"
                                                        : IZIPrice
                                                            .currencyConverterVND(
                                                                controller
                                                                    .listOrder[
                                                                        index]
                                                                    .totalPrice!),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: IZIDimensions
                                                          .FONT_SIZE_H6,
                                                      color: ColorResources.RED,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ))
                ],
              ),
      ),
    );
  }
}
