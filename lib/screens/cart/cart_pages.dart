import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/screens/cart/cart_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';

import '../../utils/config.dart';
import '../zalo_pay/zalo_pay.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CartController(),
      builder: (CartController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          // appbar
          appBar: _appBar(),
          bottomSheet: _buttonBottomSheet(controller),
          // body: Dashboard(
          //   title: AppConfig.appName,
          //   version: AppConfig.version,
          // ),
          body: Container(
            padding: EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_3X,
              horizontal: IZIDimensions.SPACE_SIZE_1X,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mặt hàng (3 món)',
                        style: TextStyle(
                          color: ColorResources.titleLogin,
                          fontFamily: NUNITO,
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Xóa tất cả',
                          style: TextStyle(
                            color: ColorResources.colorMain,
                            fontFamily: NUNITO,
                            fontWeight: FontWeight.w600,
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_2X,
                          vertical: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        margin: EdgeInsets.only(
                          top: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                IZIDimensions.BORDER_RADIUS_3X),
                            color: ColorResources.WHITE),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  IZIDimensions.BORDER_RADIUS_3X),
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      GestureDetector(
                                          onTap: () {},
                                          child: IZIImage(
                                            ImagesPath.icon_delete,
                                            width: IZIDimensions.ONE_UNIT_SIZE *
                                                35,
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                  Text(
                                    'Mì',
                                    style: TextStyle(
                                      color: ColorResources.GREY,
                                      fontFamily: NUNITO,
                                      fontWeight: FontWeight.w400,
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                    ),
                                  ),
                                  SizedBox(
                                    height: IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                  Row(
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
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          controller.reduceQuantity();
                                        },
                                        child: Container(
                                          height:
                                              IZIDimensions.ONE_UNIT_SIZE * 35,
                                          width:
                                              IZIDimensions.ONE_UNIT_SIZE * 35,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      IZIDimensions
                                                          .BORDER_RADIUS_2X),
                                              border: Border.all(
                                                  width: 0.5,
                                                  color: ColorResources.GREY)),
                                          child: Center(
                                              child: IZIImage(
                                            ImagesPath.icon_minus,
                                            width: IZIDimensions.ONE_UNIT_SIZE *
                                                20,
                                          )),
                                        ),
                                      ),
                                      Container(
                                        width: IZIDimensions.ONE_UNIT_SIZE * 50,
                                        height:
                                            IZIDimensions.ONE_UNIT_SIZE * 35,
                                        color: ColorResources.WHITE,
                                        child: Center(
                                          child: Text(
                                            controller.count.toString(),
                                            style: TextStyle(
                                              color: ColorResources.titleLogin,
                                              fontFamily: NUNITO,
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.increaseQuantity();
                                        },
                                        child: Container(
                                          height:
                                              IZIDimensions.ONE_UNIT_SIZE * 35,
                                          width:
                                              IZIDimensions.ONE_UNIT_SIZE * 35,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      IZIDimensions
                                                          .BORDER_RADIUS_2X),
                                              border: Border.all(
                                                  width: 0.5,
                                                  color: ColorResources.GREY)),
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color: ColorResources.colorMain,
                                              size:
                                                  IZIDimensions.ONE_UNIT_SIZE *
                                                      30,
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
                  ),
                  // const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///
  /// appBar
  ///
  AppBar _appBar() {
    return AppBar(
      backgroundColor: ColorResources.colorMain,
      title: const Text('Giỏ hàng của bạn'),
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
}

///
/// bottom sheet
///

Widget _buttonBottomSheet(CartController controller) {
  return Container(
    color: ColorResources.BACK_GROUND,
    height: IZIDimensions.ONE_UNIT_SIZE * 220,
    child: Column(
      children: [
        Container(
          padding:
              EdgeInsets.only(
                top: IZIDimensions.SPACE_SIZE_5X,
                left: IZIDimensions.SPACE_SIZE_4X,
                right: IZIDimensions.SPACE_SIZE_4X,
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng thanh toán : ',
                style: TextStyle(
                  color: ColorResources.titleLogin,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w600,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                ),
              ),
              Text(
                '350.000 vnđ',
                style: TextStyle(
                  color: ColorResources.colorMain,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w600,
                  fontSize: IZIDimensions.FONT_SIZE_H4,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: IZIDimensions.ONE_UNIT_SIZE * 30,
        ),
        GestureDetector(
          onTap: () {
            controller.gotoPaymentPage();
          },
          child: Container(
            height: IZIDimensions.ONE_UNIT_SIZE * 80,
            width: IZIDimensions.iziSize.width,
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_5X,
              left: IZIDimensions.SPACE_SIZE_5X,
              right: IZIDimensions.SPACE_SIZE_5X,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(IZIDimensions.BLUR_RADIUS_3X),
              color: ColorResources.colorMain,
            ),
            child: Center(
              child: Text(
                'Trang thanh toán',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Nunito',
                    color: Colors.white,
                    fontSize: IZIDimensions.FONT_SIZE_DEFAULT),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
