import 'package:flutter/material.dart';

import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/helper/izi_validate.dart';

import 'package:fooding_project/screens/payment/payment_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';

import '../../utils/id_get_builder.dart';

class PaymentPage extends GetView<PaymentController> {
  const PaymentPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PaymentController(),
      builder: (PaymentController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          appBar: _appBar(),
          bottomSheet: _bottomSheet(controller),
          body: IZIValidate.nullOrEmpty(controller.cartResponse.idUser)
              ? const Text("Chưa có món nào trong giỏ hàng!")
              : controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      margin: EdgeInsets.only(
                          bottom: IZIDimensions.ONE_UNIT_SIZE * 80),
                      padding:
                          EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_3X),
                      child: Column(
                        children: [
                          //
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // Adress.
                                  _address(controller),

                                  // listview cart
                                  if (!IZIValidate.nullOrEmpty(
                                      controller.cartResponse.listProduct))
                                    _listiCart(controller),

                                  // Phương thức thanh toán
                                  _phuongThucThanhToan(controller),

                                  // voucher của shop
                                  _voucherStore(controller),

                                  // tin nhắn cho tài xế
                                  // _messageForDriver(controller),

                                  // tổng tiền hàng
                                  _totalPriceOrder(controller),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
        );
      },
    );
  }

  ///
  /// phương thức thanh toán
  ///
  Widget _phuongThucThanhToan(PaymentController controller) {
    return Container(
      color: ColorResources.WHITE,
      width: IZIDimensions.iziSize.width,
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_3X,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_3X,
        vertical: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phương thức thanh toán',
            style: TextStyle(
              color: ColorResources.BLACK,
              fontFamily: NUNITO,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
              fontSize: IZIDimensions.FONT_SIZE_H6,
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.clickPayCash();
                },
                child: Container(
                  width: IZIDimensions.ONE_UNIT_SIZE * 250,
                  height: IZIDimensions.ONE_UNIT_SIZE * 60,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(IZIDimensions.BORDER_RADIUS_2X),
                    border:
                        Border.all(width: 0.4, color: ColorResources.colorMain),
                    color: controller.typePayment == CASH
                        ? ColorResources.colorMain
                        : ColorResources.WHITE,
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: IZIDimensions.SPACE_SIZE_5X,
                      ),
                      child: Row(
                        children: [
                          IZIImage(
                            ImagesPath.icon_money,
                            width: IZIDimensions.ONE_UNIT_SIZE * 30,
                          ),
                          SizedBox(
                            width: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          Text(
                            'Tiền mặt',
                            style: TextStyle(
                              color: controller.typePayment == CASH
                                  ? ColorResources.WHITE
                                  : ColorResources.colorMain.withOpacity(0.8),
                              fontFamily: NUNITO,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                              fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_3X,
              ),
              GestureDetector(
                onTap: () {
                  controller.clickPayBanking();
                },
                child: Container(
                  width: IZIDimensions.ONE_UNIT_SIZE * 250,
                  height: IZIDimensions.ONE_UNIT_SIZE * 60,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(IZIDimensions.BORDER_RADIUS_2X),
                    border:
                        Border.all(width: 0.4, color: ColorResources.colorMain),
                    color: controller.typePayment == BANKING
                        ? ColorResources.colorMain
                        : ColorResources.WHITE,
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: IZIDimensions.SPACE_SIZE_5X,
                      ),
                      child: Row(
                        children: [
                          IZIImage(
                            ImagesPath.icon_zalo,
                            width: IZIDimensions.ONE_UNIT_SIZE * 30,
                          ),
                          SizedBox(
                            width: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          Text(
                            'Ví ZaloPay',
                            style: TextStyle(
                              color: controller.typePayment == BANKING
                                  ? ColorResources.WHITE
                                  : ColorResources.colorMain.withOpacity(0.8),
                              fontFamily: NUNITO,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                              fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _listiCart(PaymentController controller) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: controller.cartResponse.listProduct!.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: IZIDimensions.SPACE_SIZE_2X,
            vertical: IZIDimensions.SPACE_SIZE_2X,
          ),
          margin: EdgeInsets.only(
            top: IZIDimensions.SPACE_SIZE_1X,
          ),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
              color: ColorResources.WHITE),
          child: Row(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
                child: IZIImage(
                  IZIValidate.nullOrEmpty(
                          controller.cartResponse.listProduct![index].image)
                      ? ImagesPath.placeHolder
                      : controller.cartResponse.listProduct![index].image![0]
                          .toString(),
                  height: IZIDimensions.ONE_UNIT_SIZE * 150,
                  width: IZIDimensions.ONE_UNIT_SIZE * 150,
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_1X,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            IZIValidate.nullOrEmpty(controller
                                    .cartResponse.listProduct![index].name)
                                ? "Không xác định"
                                : controller
                                    .cartResponse.listProduct![index].name!,
                            style: TextStyle(
                              color: ColorResources.titleLogin,
                              fontFamily: NUNITO,
                              fontWeight: FontWeight.w600,
                              fontSize: IZIDimensions.FONT_SIZE_H6,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.clickDelete(index);
                          },
                          child: IZIImage(
                            ImagesPath.icon_delete,
                            width: IZIDimensions.ONE_UNIT_SIZE * 35,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    Text(
                      IZIValidate.nullOrEmpty(controller
                              .cartResponse.listProduct![index].nameCategory)
                          ? "Không xác định"
                          : controller
                              .cartResponse.listProduct![index].nameCategory!,
                      style: TextStyle(
                        color: ColorResources.GREY,
                        fontFamily: NUNITO,
                        fontWeight: FontWeight.w400,
                        fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                      ),
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    Row(
                      children: [
                        Text(
                          IZIValidate.nullOrEmpty(controller
                                  .cartResponse.listProduct![index].price)
                              ? "Không xác định"
                              : "${IZIPrice.currencyConverterVND(controller.cartResponse.listProduct![index].price!.toDouble())}vnđ",
                          style: TextStyle(
                            color: ColorResources.colorMain,
                            fontFamily: NUNITO,
                            fontWeight: FontWeight.w600,
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            controller.onClickMinus(index);
                          },
                          child: Container(
                            height: IZIDimensions.ONE_UNIT_SIZE * 35,
                            width: IZIDimensions.ONE_UNIT_SIZE * 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    IZIDimensions.BORDER_RADIUS_2X),
                                border: Border.all(
                                    width: 0.5, color: ColorResources.GREY)),
                            child: Center(
                                child: IZIImage(
                              ImagesPath.icon_minus,
                              width: IZIDimensions.ONE_UNIT_SIZE * 20,
                            )),
                          ),
                        ),
                        SizedBox(
                          width: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        GetBuilder(
                            id: ID_LOADING_CLICK_PAYMENT,
                            builder: (PaymentController controller) {
                              return Text(
                                IZIValidate.nullOrEmpty(controller.cartResponse
                                        .listProduct![index].quantity)
                                    ? "Không xác định"
                                    : "x${controller.cartResponse.listProduct![index].quantity}",
                                style: TextStyle(
                                  color: ColorResources.GREY,
                                  fontFamily: NUNITO,
                                  fontWeight: FontWeight.w400,
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                ),
                              );
                            }),
                        SizedBox(
                          width: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.onClickPlus(index);
                          },
                          child: Container(
                            height: IZIDimensions.ONE_UNIT_SIZE * 35,
                            width: IZIDimensions.ONE_UNIT_SIZE * 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    IZIDimensions.BORDER_RADIUS_2X),
                                border: Border.all(
                                    width: 0.5, color: ColorResources.GREY)),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: ColorResources.colorMain,
                                size: IZIDimensions.ONE_UNIT_SIZE * 30,
                              ),
                            ),
                          ),
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
    );
  }

  Widget _bottomSheet(PaymentController controller) {
    return IZIValidate.nullOrEmpty(controller.cartResponse.listProduct)
        ? const SizedBox()
        : SizedBox(
            height: IZIDimensions.ONE_UNIT_SIZE * 80,
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                    color: ColorResources.WHITE,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tổng thanh toán : ',
                            style: TextStyle(
                              color: ColorResources.BLACK,
                              fontFamily: NUNITO,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                              fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            ),
                          ),
                          Text(
                            '${IZIPrice.currencyConverterVND(controller.totalPay())}vnđ',
                            style: TextStyle(
                              color: ColorResources.colorMain,
                              fontFamily: NUNITO,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                              fontSize: IZIDimensions.FONT_SIZE_H4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.onClickPay();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_5X * 1.2,
                    ),
                    decoration: BoxDecoration(
                      color: ColorResources.colorMain,
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BLUR_RADIUS_2X,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Đặt hàng',
                        style: TextStyle(
                          color: ColorResources.WHITE,
                          fontFamily: NUNITO,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  ///
  /// voucher store
  ///
  Widget _voucherStore(PaymentController controller) {
    return Column(
      children: [
        const Divider(
          height: 1,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            color: ColorResources.WHITE,
            // margin: EdgeInsets.only(
            //   top: IZIDimensions.SPACE_SIZE_1X,
            // ),
            padding: EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_2X,
              horizontal: IZIDimensions.SPACE_SIZE_3X,
            ),
            child: GestureDetector(
              onTap: () {
                controller.goToVoucher();
              },
              child: Row(
                children: [
                  Text(
                    'Voucher của bạn',
                    style: TextStyle(
                      color: ColorResources.BLACK,
                      fontFamily: NUNITO,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Chọn hoặc nhập mã',
                    style: TextStyle(
                      color: ColorResources.GREY,
                      fontFamily: NUNITO,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: ColorResources.GREY,
                    size: IZIDimensions.ONE_UNIT_SIZE * 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _totalPriceOrder(PaymentController controller) {
    return Container(
      width: IZIDimensions.iziSize.width,
      color: ColorResources.WHITE,
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_1X,
        bottom: IZIDimensions.SPACE_SIZE_2X,
      ),
      padding: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_2X,
        left: IZIDimensions.SPACE_SIZE_2X,
        right: IZIDimensions.SPACE_SIZE_2X,
        bottom: IZIDimensions.SPACE_SIZE_1X,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chi tiết thanh toán',
            style: TextStyle(
              color: ColorResources.BLACK,
              fontFamily: NUNITO,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
              fontSize: IZIDimensions.FONT_SIZE_H6,
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tạm tính',
                style: TextStyle(
                  color: ColorResources.GREY,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                  fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                ),
              ),
              Text(
                '${IZIPrice.currencyConverterVND(controller.tamtinh)}vnđ',
                style: TextStyle(
                  color: ColorResources.GREY,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                  fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                ),
              ),
            ],
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                //'Phí vận chuyển(${IZIValidate.nullOrEmpty(controller.distance) ? "unknown" : IZIValidate.nullOrEmpty(controller.distance!.rows) ? "Unknown" : controller.distance!.rows[0].elements[0].distance.text})',
                'Phí vận chuyển(${IZIValidate.nullOrEmpty(controller.distance) ? "unknown" : controller.distance.toString()} km)',
                style: TextStyle(
                  color: ColorResources.GREY,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                  fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                ),
              ),
              Text(
                IZIValidate.nullOrEmpty(controller.priceShip)
                    ? "Unknow"
                    : '${IZIPrice.currencyConverterVND(controller.priceShip)}vnđ',
                style: TextStyle(
                  color: ColorResources.GREY,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                  fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                ),
              ),
            ],
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          IZIValidate.nullOrEmpty(controller.myVourcher)
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Giảm giá',
                      style: TextStyle(
                        color: ColorResources.GREY,
                        fontFamily: NUNITO,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                        fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                      ),
                    ),
                    Text(
                      '12.000 vnđ',
                      style: TextStyle(
                        color: ColorResources.GREY,
                        fontFamily: NUNITO,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                        fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
        ],
      ),
    );
  }
}

///
/// address.
///
Widget _address(PaymentController controller) {
  return GestureDetector(
    onTap: () {
      controller.gotoLocation();
    },
    child: Container(
      height: IZIValidate.nullOrEmpty(controller.userResponse.idLocation)
          ? IZIDimensions.iziSize.height * 0.1
          : IZIDimensions.iziSize.height * 0.14,
      width: IZIDimensions.iziSize.width,
      color: ColorResources.WHITE,
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_2X,
        horizontal: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Địa chỉ nhận hàng',
                  style: TextStyle(
                    color: ColorResources.BLACK,
                    fontFamily: NUNITO,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                  ),
                ),
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_1X,
                ),
                IZIValidate.nullOrEmpty(controller.userResponse.idLocation)
                    ? const Center(
                        child: Text("Bạn có chọn địa chỉ giao hàng"),
                      )
                    : Row(
                        children: [
                          Text(
                            '${IZIValidate.nullOrEmpty(controller.location.name) ? "No Name" : controller.location.name} ',
                            style: TextStyle(
                              color: ColorResources.GREY,
                              fontFamily: NUNITO,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                              fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            ),
                          ),
                          Text(
                            '| ${IZIValidate.nullOrEmpty(controller.location.phone) ? "No Name" : controller.location.phone}',
                            style: TextStyle(
                              color: ColorResources.GREY,
                              fontFamily: NUNITO,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                              fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            ),
                          ),
                        ],
                      ),
                IZIValidate.nullOrEmpty(controller.userResponse.idLocation)
                    ? const SizedBox()
                    : Expanded(
                        child: Text(
                          IZIValidate.nullOrEmpty(
                                  controller.userResponse.idLocation)
                              ? "Bạn chưa chọn địa chỉ giao hàng"
                              : controller.location.address!,
                          maxLines: 2,
                          style: TextStyle(
                            color: ColorResources.GREY,
                            fontFamily: NUNITO,
                            fontWeight: FontWeight.w400,
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                          ),
                        ),
                      ),
              ],
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: ColorResources.GREY,
            size: IZIDimensions.ONE_UNIT_SIZE * 40,
          )
        ],
      ),
    ),
  );
}

///
/// appBar
///
AppBar _appBar() {
  return AppBar(
    backgroundColor: ColorResources.colorMain,
    title: const Text('Trang đặt hàng'),
    titleTextStyle: TextStyle(
      color: ColorResources.WHITE,
      fontFamily: NUNITO,
      fontWeight: FontWeight.w600,
      fontSize: IZIDimensions.FONT_SIZE_H5,
    ),
    centerTitle: true,
    elevation: 0,
  );
}
