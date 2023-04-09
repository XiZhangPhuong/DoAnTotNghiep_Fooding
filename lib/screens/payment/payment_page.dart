import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_drop_down_button.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_size.dart';
import 'package:fooding_project/screens/payment/payment_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';

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
          body: Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.ONE_UNIT_SIZE*80
            ),
            padding: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_3X),
            child: Column(
              children: [
                // filter province
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // districts
                    Container(
                      width: IZIDimensions.ONE_UNIT_SIZE * 270,
                      height: IZIDimensions.ONE_UNIT_SIZE * 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            IZIDimensions.BORDER_RADIUS_4X),
                        border: Border.all(
                            width: 0.4, color: ColorResources.colorMain),
                        color: ColorResources.WHITE,
                      ),
                      child: Center(
                        child: DropdownButton(
                          underline: const SizedBox(),
                          isExpanded: true,
                          elevation: 0,
                          value: controller.selectedBenh,
                          icon: Container(
                            padding: EdgeInsets.only(
                                right: IZIDimensions.SPACE_SIZE_4X),
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: (Icon(
                                Icons.arrow_back_ios_sharp,
                                size: IZIDimensions.ONE_UNIT_SIZE * 25,
                                color: ColorResources.BLACK,
                              )),
                            ),
                          ),
                          items: controller.listBenh.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Container(
                                // width: IZIDimensions.SPACE_SIZE_5X * 14,
                                padding: EdgeInsets.only(
                                    left: IZIDimensions.SPACE_SIZE_4X),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontFamily: NUNITO,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            controller.setSelectedBenh(value.toString());
                          },
                        ),
                      ),
                    ),
                    // wards
                    Container(
                      width: IZIDimensions.ONE_UNIT_SIZE * 270,
                      height: IZIDimensions.ONE_UNIT_SIZE * 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            IZIDimensions.BORDER_RADIUS_4X),
                        border: Border.all(
                            width: 0.4, color: ColorResources.colorMain),
                        color: ColorResources.WHITE,
                      ),
                      child: Center(
                        child: DropdownButton(
                          underline: const SizedBox(),
                          isExpanded: true,
                          elevation: 0,
                          value: controller.selectedBenh,
                          icon: Container(
                            padding: EdgeInsets.only(
                                right: IZIDimensions.SPACE_SIZE_4X),
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: (Icon(
                                Icons.arrow_back_ios_sharp,
                                size: IZIDimensions.ONE_UNIT_SIZE * 25,
                                color: ColorResources.BLACK,
                              )),
                            ),
                          ),
                          items: controller.listBenh.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Container(
                                // width: IZIDimensions.SPACE_SIZE_5X * 14,
                                padding: EdgeInsets.only(
                                    left: IZIDimensions.SPACE_SIZE_4X),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontFamily: NUNITO,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            controller.setSelectedBenh(value.toString());
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                //
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_2X,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // listview cart
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
                  controller.clickPayMentMeThod();
                },
                child: Container(
                  width: IZIDimensions.ONE_UNIT_SIZE * 250,
                  height: IZIDimensions.ONE_UNIT_SIZE * 60,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(IZIDimensions.BORDER_RADIUS_2X),
                      border: Border.all(
                          width: 0.4, color: ColorResources.colorMain),
                      color: controller.clickpayment==true ? ColorResources.colorMain : ColorResources.WHITE
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
                              color: ColorResources.colorMain.withOpacity(0.8),
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
                  controller.clickPayMentMeThod();
                },
                child: Container(
                  width: IZIDimensions.ONE_UNIT_SIZE * 250,
                  height: IZIDimensions.ONE_UNIT_SIZE * 60,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(IZIDimensions.BORDER_RADIUS_2X),
                    border:
                        Border.all(width: 0.4, color: ColorResources.colorMain
                        ),
                    color: controller.clickpayment==true ?  ColorResources.WHITE :ColorResources.colorMain 
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
                              color: ColorResources.colorMain.withOpacity(0.8),
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
      itemCount: 3,
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
                  controller.listImageSlider.first,
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
                    Text(
                      'Mì sảo hải sản',
                      style: TextStyle(
                        color: ColorResources.titleLogin,
                        fontFamily: NUNITO,
                        fontWeight: FontWeight.w600,
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                      ),
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    Text(
                      'Bún|Mì',
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '125.000 vnđ',
                          style: TextStyle(
                            color: ColorResources.colorMain,
                            fontFamily: NUNITO,
                            fontWeight: FontWeight.w600,
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                          ),
                        ),
                        Text(
                          'x3',
                          style: TextStyle(
                            color: ColorResources.GREY,
                            fontFamily: NUNITO,
                            fontWeight: FontWeight.w400,
                            fontSize: IZIDimensions.FONT_SIZE_H6,
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
    return SizedBox(
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
                      '125.000 vnđ',
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
            onTap: () {},
            child: Flexible(
              flex: 1,
              child: Container(
                color: ColorResources.colorMain,
                padding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.SPACE_SIZE_5X * 1.2,
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
            child: Row(
              children: [
                Text(
                  'Voucher cửa hàng',
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
      ],
    );
  }

  Widget _totalPriceOrder(PaymentController controller) {
    return Container(
      width: IZIDimensions.iziSize.width,
      color: ColorResources.WHITE,
      margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X,
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
                '25.000 vnđ',
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
          SizedBox(height: IZIDimensions.SPACE_SIZE_1X,),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Phí vận chuyển',
                style: TextStyle(
                  color: ColorResources.GREY,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                  fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                ),
              ),
              Text(
                '25.000 vnđ',
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
           SizedBox(height: IZIDimensions.SPACE_SIZE_1X,),
           Row(
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
                '- 12.000 vnđ',
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
           SizedBox(height: IZIDimensions.SPACE_SIZE_1X,),
           const Divider(height: 1,color: ColorResources.GREY,),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng thanh toán',
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                ),
              ),
              Text(
                '550.000 vnđ',
                style: TextStyle(
                  color: ColorResources.colorMain,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  fontSize: IZIDimensions.FONT_SIZE_H4,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

///
/// tin nhắn cho tài xế
///
Widget _messageForDriver(PaymentController controller) {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tin nhắn cho tài xế',
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                ),
              ),
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
            ],
          ),
        ),
      ),
    ],
  );
}

///
/// appBar
///
AppBar _appBar() {
  return AppBar(
    backgroundColor: ColorResources.colorMain,
    title: const Text('Trang thanh toán'),
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
