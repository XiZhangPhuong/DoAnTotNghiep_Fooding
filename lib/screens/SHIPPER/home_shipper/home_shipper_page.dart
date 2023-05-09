import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/izi_loading_card.dart';
import 'package:fooding_project/base_widget/p45_appbar.dart';
import 'package:fooding_project/base_widget/p45_button.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/screens/SHIPPER/home_shipper/home_shipper_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class HomeShipperPage extends GetView<HomeShipperController> {
  const HomeShipperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeShipperController(),
      builder: (HomeShipperController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          floatingActionButton: _checkOline(controller),
          body: controller.isLoadingOrder == false
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  child: _viewInforOrder(controller),
                ),
        );
      },
    );
  }
}

///
/// listview product
///
Widget _listviewProducts(HomeShipperController controller) {
  return controller.isLoadingOrder == false
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : Container(
          margin: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_3X),
          height: IZIDimensions.ONE_UNIT_SIZE * 200,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.orderResponse!.listProduct!.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(IZIDimensions.SPACE_SIZE_3X),
                    color: ColorResources.WHITE),
                height: IZIDimensions.ONE_UNIT_SIZE * 200,
                width: IZIDimensions.iziSize.width * 0.9,
                padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(IZIDimensions.SPACE_SIZE_3X),
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
                            fontSize: IZIDimensions.FONT_SIZE_H5,
                          ),
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        Text(
                          controller.priceProduct(
                              controller.orderResponse!.listProduct![index]
                                  .priceDiscount!,
                              controller
                                  .orderResponse!.listProduct![index].price!),
                          style: TextStyle(
                            color: ColorResources.BLACK,
                            fontFamily: NUNITO,
                            fontWeight: FontWeight.w600,
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              );
            },
          ),
        );
}

///
/// floatitng button check oline
///
Widget _checkOline(HomeShipperController controller) {
  return GestureDetector(
    onTap: () {
      controller.clickTickOline();
    },
    child: Container(
      height: IZIDimensions.ONE_UNIT_SIZE * 150,
      width: IZIDimensions.ONE_UNIT_SIZE * 150,
      // padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: controller.isCheckOline ? ColorResources.colorMain : null,
      ),
      child: Center(
          child: Icon(
        Icons.power_settings_new,
        size: IZIDimensions.ONE_UNIT_SIZE * 150,
        color: controller.isCheckOline
            ? ColorResources.WHITE
            : ColorResources.BLACK,
      )),
    ),
  );
}

///
/// view confirm when order not null
///
Widget _viewConfirm(HomeShipperController controller) {
  return Center(
    child: Column(
      children: [
        Text(
          "Bạn có 1 đơn hàng mới".toUpperCase(),
          style: TextStyle(
            color: ColorResources.BLACK,
            fontWeight: FontWeight.w600,
            fontSize: IZIDimensions.FONT_SIZE_H6,
            fontFamily: NUNITO,
          ),
        ),
      ],
    ),
  );
}

///
/// view inforOrder
///
Widget _viewInforOrder(HomeShipperController controller) {
  if (controller.listOrder.isEmpty) {
    return Center(
      child: Text(
        "Chưa có đơn hàng",
        style: TextStyle(
          color: ColorResources.WHITE,
          fontWeight: FontWeight.w600,
          fontSize: IZIDimensions.FONT_SIZE_H6,
          fontFamily: NUNITO,
        ),
      ),
    );
  } else {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: IZIDimensions.SPACE_SIZE_5X,
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_5X),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bạn có 1 đơn hàng mới".toUpperCase(),
                    style: TextStyle(
                      color: ColorResources.BLACK,
                      fontWeight: FontWeight.w600,
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontFamily: NUNITO,
                    ),
                  ),
                  Text(
                    "${controller.orderResponse!.listProduct!.length}sản phẩm",
                    style: TextStyle(
                      color: ColorResources.colorMain,
                      fontWeight: FontWeight.w600,
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontFamily: NUNITO,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: IZIDimensions.SPACE_SIZE_3X,
            ),
            _listviewProducts(controller),
            SizedBox(
              height: IZIDimensions.SPACE_SIZE_2X,
            ),
            // view infor user
            Container(
              width: IZIDimensions.iziSize.width,
              margin: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.BLUR_RADIUS_5X),
              padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
                  color: ColorResources.WHITE),
              child: controller.isLoadingCustommer == false
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: IZIImage(
                              IZIValidate.nullOrEmpty(
                                      controller.custommerReponse!.avatar)
                                  ? 'https://media.baobinhphuoc.com.vn/upload/news/1_2023/manchesterunitedmancity1_07061115012023.jpeg'
                                  : controller.custommerReponse!.avatar!,
                              height: IZIDimensions.ONE_UNIT_SIZE * 100,
                              width: IZIDimensions.ONE_UNIT_SIZE * 100),
                        ),
                        SizedBox(
                          width: IZIDimensions.SPACE_SIZE_3X,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                IZIValidate.nullOrEmpty(
                                        controller.orderResponse!.name)
                                    ? 'Lê Thị Thu Phượng'
                                    : controller.orderResponse!.name!,
                                style: TextStyle(
                                  color: ColorResources.BLACK,
                                  fontWeight: FontWeight.w600,
                                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                  fontFamily: NUNITO,
                                ),
                              ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              Text(
                                IZIValidate.nullOrEmpty(
                                        controller.orderResponse!.phone)
                                    ? '05555555'
                                    : controller.orderResponse!.phone!,
                                style: TextStyle(
                                  color: ColorResources.BLACK,
                                  fontWeight: FontWeight.w600,
                                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                  fontFamily: NUNITO,
                                ),
                              ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              Text(
                                IZIValidate.nullOrEmpty(
                                        controller.orderResponse!.address)
                                    ? '120 Hoài Xuân'
                                    : controller.orderResponse!.address!,
                                style: TextStyle(
                                  color: ColorResources.BLACK,
                                  fontWeight: FontWeight.w600,
                                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: NUNITO,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
            ),

            // infor price order
            Container(
              margin: EdgeInsets.only(
                top: IZIDimensions.SPACE_SIZE_3X,
                left: IZIDimensions.BLUR_RADIUS_3X,
                right: IZIDimensions.BLUR_RADIUS_3X,
              ),
              padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(IZIDimensions.SPACE_SIZE_3X),
                color: ColorResources.WHITE,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tạm tính : ',
                        style: TextStyle(
                          color: ColorResources.BLACK,
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          fontFamily: NUNITO,
                        ),
                      ),
                      Text(
                        '${IZIPrice.currencyConverterVND(controller.tamTinh(list: controller.orderResponse!.listProduct!), 'vnđ')}vnđ',
                        style: TextStyle(
                          color: ColorResources.colorMain,
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          fontFamily: NUNITO,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tiền Ship : ',
                        style: TextStyle(
                          color: ColorResources.BLACK,
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          fontFamily: NUNITO,
                        ),
                      ),
                      Text(
                        "${IZIPrice.currencyConverterVND(controller.orderResponse!.shipPrice!, 'đ')}vnđ",
                        style: TextStyle(
                          color: ColorResources.colorMain,
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          fontFamily: NUNITO,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng tiền : ',
                        style: TextStyle(
                          color: ColorResources.BLACK,
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          fontFamily: NUNITO,
                        ),
                      ),
                      Text(
                        '${IZIPrice.currencyConverterVND(controller.orderResponse!.totalPrice!, 'đ')}vnđ',
                        style: TextStyle(
                          color: ColorResources.colorMain,
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          fontFamily: NUNITO,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phương thức thanh toán : ',
                        style: TextStyle(
                          color: ColorResources.BLACK,
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          fontFamily: NUNITO,
                        ),
                      ),
                      Text(
                        controller.convertMethodPay(
                            method: controller.orderResponse!.typePayment!),
                        style: TextStyle(
                          color: ColorResources.colorMain,
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          fontFamily: NUNITO,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(
              height: IZIDimensions.SPACE_SIZE_4X,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: IZIDimensions.iziSize.width * 0.5,
                  child: P45Button(
                    title: 'Hủy',
                    color: Colors.blue,
                    onPressed: () {},
                  ),
                ),
                Container(
                  width: IZIDimensions.iziSize.width * 0.5,
                  child: P45Button(
                    title: 'Chấp nhận',
                    onPressed: () {
                      controller.clickConfirm(orderResponse: controller.orderResponse!);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
