import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/screens/widgets/app_bar.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';

class DetailOrderPage extends GetView {
  const DetailOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFooding(title: "Chi Tiết đơn hàng"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            IZIDimensions.SPACE_SIZE_3X,
          ),
          child: Column(
            children: [
              //
              // Infor Delivery Person.
              _inforDeliveryPerson(),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_2X,
              ),
              //
              // infor Location.
              _inforLocation(),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_2X,
              ),
              //
              // Infor Order
              _inforOrder(),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_2X,
              ),
              _payment(),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_2X,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    IZIDimensions.BORDER_RADIUS_4X,
                  ),
                ),
                padding: EdgeInsets.all(
                  IZIDimensions.SPACE_SIZE_1X,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Mã đơn hàng",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "sjkdfghjk12",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            fontWeight: FontWeight.w500,
                            color: ColorResources.colorMain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    Row(
                      children: [
                        Text(
                          "Thời gian đặt hàng",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "15:25 07/05/2023",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    Row(
                      children: [
                        Text(
                          "Thời gian xác nhận",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "15:25 07/05/2023",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    Row(
                      children: [
                        Text(
                          "Thời gian lấy món ăn",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "15:25 07/05/2023",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    Row(
                      children: [
                        Text(
                          "Thời gian giao thành công",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "15:25 07/05/2023",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_2X,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _payment() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_4X,
        ),
      ),
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_1X,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.payment,
            color: Colors.redAccent,
            size: IZIDimensions.ONE_UNIT_SIZE * 50,
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_2X,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Phương Thức thanh toán",
                style: TextStyle(
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w700,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_1X,
              ),
              Text(
                "Thanh toán bằng tiền mặt",
                style: TextStyle(
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w400,
                  fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  ///
  /// Infor order.
  ///
  Widget _inforOrder() {
    return Container(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_1X,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_4X,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.store,
                color: Colors.redAccent,
                size: IZIDimensions.ONE_UNIT_SIZE * 50,
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_3X,
              ),
              Text(
                "Hoàn Mỹ Sport",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: NUNITO,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                ),
              ),
              const Spacer(),
              const Text(
                "Xem shop >>>",
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
            height: IZIDimensions.iziSize.height * 0.13,
            width: IZIDimensions.iziSize.width,
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  height: IZIDimensions.iziSize.height * 0.13,
                  width: IZIDimensions.iziSize.width * 0.8,
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_2X,
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
                        borderRadius: BorderRadius.circular(
                            IZIDimensions.BORDER_RADIUS_3X),
                        child: IZIImage(
                          ImagesPath.placeHolder,
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
                              "Gà ủ muối",
                              style: TextStyle(
                                color: ColorResources.colorMain,
                                fontFamily: NUNITO,
                                fontWeight: FontWeight.w600,
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                              ),
                            ),
                            Text(
                              "Số lượng : 1",
                              style: TextStyle(
                                color: ColorResources.GREY,
                                fontFamily: NUNITO,
                                fontWeight: FontWeight.w400,
                                fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Giá tiền : 150.000",
                                  style: TextStyle(
                                    color: ColorResources.GREY,
                                    fontFamily: NUNITO,
                                    fontWeight: FontWeight.w400,
                                    fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
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
                "Tổng đơn",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                  color: ColorResources.RED,
                ),
              ),
              const Spacer(),
              Text(
                "120.000",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                  color: ColorResources.RED,
                ),
              ),
            ],
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
        ],
      ),
    );
  }

  ///
  /// Infor Delivery Person.
  ///
  Widget _inforDeliveryPerson() {
    return Container(
      height: IZIDimensions.iziSize.height * 0.18,
      width: IZIDimensions.iziSize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_4X,
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.delivery_dining,
                color: Colors.redAccent,
                size: IZIDimensions.ONE_UNIT_SIZE * 50,
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),
              Text(
                "Thông tin tài xế",
                style: TextStyle(
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w700,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                ),
              ),
            ],
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Row(
            children: [
              ClipOval(
                child: IZIImage(
                  ImagesPath.imageIntroduction1,
                  height: IZIDimensions.ONE_UNIT_SIZE * 150,
                  width: IZIDimensions.ONE_UNIT_SIZE * 150,
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_4X,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: ColorResources.BLACK,
                          fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                          fontWeight: FontWeight.w400,
                        ),
                        children: const [
                          TextSpan(
                            text: "Họ và tên: ",
                          ),
                          TextSpan(
                            text: "Trương Đình Quyền",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: ColorResources.BLACK,
                          fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                          fontWeight: FontWeight.w400,
                        ),
                        children: const [
                          TextSpan(
                            text: "Số điện thoại: ",
                          ),
                          TextSpan(
                            text: "Trương Đình Quyền",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: ColorResources.BLACK,
                          fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                          fontWeight: FontWeight.w400,
                        ),
                        children: const [
                          TextSpan(
                            text: "Biển số xe: ",
                          ),
                          TextSpan(
                            text: "Trương Đình Quyền",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  ///
  /// Infor Location Person.
  ///
  Widget _inforLocation() {
    return Container(
      width: IZIDimensions.iziSize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_4X,
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_city,
                color: Colors.redAccent,
                size: IZIDimensions.ONE_UNIT_SIZE * 50,
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),
              Text(
                "Địa chỉ nhận hàng",
                style: TextStyle(
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w700,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                ),
              ),
            ],
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Container(
            margin: EdgeInsets.only(
              left: IZIDimensions.SPACE_SIZE_5X,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: ColorResources.BLACK,
                      fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                      fontWeight: FontWeight.w400,
                    ),
                    children: const [
                      TextSpan(
                        text: "Họ và tên: ",
                      ),
                      TextSpan(
                        text: "Trương Đình Quyền",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_3X,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: ColorResources.BLACK,
                      fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                      fontWeight: FontWeight.w400,
                    ),
                    children: const [
                      TextSpan(
                        text: "Số điện thoại: ",
                      ),
                      TextSpan(
                        text: "0332854541",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_3X,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: ColorResources.BLACK,
                      fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                      fontWeight: FontWeight.w400,
                    ),
                    children: const [
                      TextSpan(
                        text: "Địa chỉ: ",
                      ),
                      TextSpan(
                        text: "55 Lưu Hữu Phước, An Hải Bắc, Đà Nẵng, Việt Nam",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
        ],
      ),
    );
  }
}
