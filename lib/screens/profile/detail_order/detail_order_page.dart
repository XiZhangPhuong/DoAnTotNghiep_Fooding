import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/p45_appbar.dart';
import 'package:fooding_project/base_widget/p45_button.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/routes/routes_path/fell_rating_routes.dart';
import 'package:fooding_project/routes/routes_path/profile_routes.dart';
import 'package:fooding_project/screens/profile/detail_order/detail_order_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';

class DetailOrderPage extends GetView {
  const DetailOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const P45AppBarP(title: 'Chi tiết đơn hàng'),
      body: GetBuilder(
          init: DetailOrderController(),
          builder: (DetailOrderController controller) {
            return controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(
                        IZIDimensions.SPACE_SIZE_3X,
                      ),
                      child: Column(
                        children: [
                          //
                          // Infor Delivery Person.
                          if (!IZIValidate.nullOrEmpty(
                              controller.orderResponse.idEmployee))
                            _inforDeliveryPerson(controller),
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          //
                          // infor Location.
                          _inforLocation(controller),
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          //
                          // Infor Order
                          _inforOrder(controller),
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          _payment(controller),
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          _note(controller),
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
                                        fontSize:
                                            IZIDimensions.FONT_SIZE_DEFAULT,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      IZIValidate.nullOrEmpty(
                                              controller.orderResponse.id)
                                          ? "Không xác định"
                                          : controller.orderResponse.id!
                                              .substring(20),
                                      style: TextStyle(
                                        fontSize:
                                            IZIDimensions.FONT_SIZE_DEFAULT,
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
                                      "Dự kiến giao hàng thành công",
                                      style: TextStyle(
                                        fontSize:
                                            IZIDimensions.FONT_SIZE_DEFAULT,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      IZIValidate.nullOrEmpty(controller
                                              .orderResponse.timeDelivery)
                                          ? "Không xác định"
                                          : "${controller.orderResponse.timeDelivery!} phút",
                                      style: TextStyle(
                                        fontSize:
                                            IZIDimensions.FONT_SIZE_DEFAULT,
                                        fontWeight: FontWeight.w500,
                                        color: ColorResources.colorMain,
                                      ),
                                    ),
                                  ],
                                ),
                                _itemTime(
                                  title: "Thời gian đặt hàng",
                                  content: IZIValidate.nullOrEmpty(
                                          controller.orderResponse.timePeding)
                                      ? "Không xác định"
                                      : controller.orderResponse.timePeding!,
                                ),
                                if (!IZIValidate.nullOrEmpty(
                                    controller.orderResponse.timeConfirm))
                                  _itemTime(
                                    title: "Thời gian xác nhận",
                                    content:
                                        controller.orderResponse.timeConfirm!,
                                  ),
                                if (!IZIValidate.nullOrEmpty(
                                    controller.orderResponse.timeDelivering))
                                  _itemTime(
                                    title: "Lấy thành công, đang giao",
                                    content: controller
                                        .orderResponse.timeDelivering!,
                                  ),
                                if (!IZIValidate.nullOrEmpty(
                                    controller.orderResponse.timeDone))
                                  _itemTime(
                                    title: "Giao thành công",
                                    content: controller.orderResponse.timeDone!,
                                  ),
                                if (!IZIValidate.nullOrEmpty(
                                    controller.orderResponse.timeCancel))
                                  _itemTime(
                                    title: "Lấy thành công, đang giao",
                                    content:
                                        controller.orderResponse.timeCancel!,
                                  ),
                                SizedBox(
                                  height: IZIDimensions.iziSize.height * 0.1,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
          }),
      bottomSheet: GetBuilder(
          init: DetailOrderController(),
          builder: (DetailOrderController controller) {
            return controller.orderResponse.statusOrder == PENDING ||
                    controller.orderResponse.statusOrder == DELIVERING ||
                    controller.orderResponse.statusOrder == DONE
                ? Container(
                    height: IZIDimensions.iziSize.height * 0.08,
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    child: Row(
                      children: [
                        if (controller.orderResponse.statusOrder == PENDING)
                          Expanded(
                            child: button(
                              title: "Hủy đơn hàng",
                              onPressed: () {
                                controller.handleCancleOrder();
                              },
                            ),
                          ),
                        if (controller.orderResponse.statusOrder == DELIVERING)
                          Expanded(
                            child: Row(
                              children: [
                                if (controller.orderResponse.timeConfirm ==
                                        null ||
                                    DateTime.parse(controller
                                                .orderResponse.timePeding!)
                                            .add(Duration(
                                                minutes: int.parse(controller
                                                    .orderResponse
                                                    .timeDelivery!)))
                                            .millisecondsSinceEpoch <
                                        DateTime.now().millisecondsSinceEpoch)
                                  Expanded(
                                    child: button(
                                      title: "Hủy đơn hàng",
                                      onPressed: () {
                                        controller.handleCancleOrder();
                                      },
                                    ),
                                  ),
                                Expanded(
                                  child: button(
                                    title: "Trạng thái giao hàng",
                                    onPressed: () {
                                      controller.gotoGoogleMapMaker();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (controller.orderResponse.statusOrder == DONE)
                          Expanded(
                            child: button(
                              title: "Đánh giá",
                              onPressed: () {
                                Get.toNamed(
                                  FillRatingRoutes.REVIEW_FOOD,
                                  arguments: controller.orderResponse.id,
                                );
                              },
                            ),
                          ),
                      ],
                    ))
                : const SizedBox();
          }),
      floatingActionButton: GetBuilder(
          init: DetailOrderController(),
          builder: (controller) {
            return controller.orderResponse.statusOrder == DELIVERING
                ? GestureDetector(
                    onTap: () {
                      Get.toNamed(ProfileRoutes.CHAT,
                          arguments: controller.orderResponse);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: IZIDimensions.iziSize.height * 0.05),
                      height: IZIDimensions.ONE_UNIT_SIZE * 70,
                      width: IZIDimensions.ONE_UNIT_SIZE * 70,
                      child: Icon(
                        Icons.message_sharp,
                        color: Colors.red,
                        size: IZIDimensions.ONE_UNIT_SIZE * 50,
                      ),
                    ),
                  )
                : const SizedBox();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  ///
  /// Button.
  ///
  Widget button({required Function onPressed, required String title}) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: IZIDimensions.ONE_UNIT_SIZE * 80,
        margin: EdgeInsets.only(
            left: IZIDimensions.SPACE_SIZE_2X,
            right: IZIDimensions.SPACE_SIZE_2X,
            bottom: IZIDimensions.SPACE_SIZE_1X),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(IZIDimensions.SPACE_SIZE_1X),
          color: ColorResources.colorMain,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Nunito',
              color: ColorResources.WHITE,
              fontSize: IZIDimensions.FONT_SIZE_H6,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// Item time.
  ///
  Widget _itemTime({required String title, required String content}) {
    return Column(
      children: [
        SizedBox(
          height: IZIDimensions.SPACE_SIZE_1X,
        ),
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              content,
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  ///
  /// Payment.
  ///
  Container _payment(DetailOrderController controller) {
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
                "Thanh toán bằng ${controller.orderResponse.typePayment == CASH ? "tiền mặt" : "chuyển khoản"} ",
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
  /// Note.
  ///
  Container _note(DetailOrderController controller) {
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
            Icons.note,
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
                "Ghi chú",
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
                IZIValidate.nullOrEmpty(controller.orderResponse.note)
                    ? "Không có ghi chú"
                    : controller.orderResponse.note!,
                maxLines: 6,
                style: TextStyle(
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w400,
                  fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                  overflow: TextOverflow.ellipsis,
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
  Widget _inforOrder(DetailOrderController controller) {
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
                IZIValidate.nullOrEmpty(controller.storeResponse.fullName)
                    ? "Không xác định"
                    : controller.storeResponse.fullName!,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: NUNITO,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // do something.
                  controller.goToShop();
                },
                child: const Text(
                  "Xem shop",
                  style: TextStyle(
                    color: ColorResources.colorMain,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right_outlined,
                color: ColorResources.colorMain,
              )
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
              shrinkWrap: true,
              itemCount: controller.orderResponse.listProduct!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final itemProduct =
                    controller.orderResponse.listProduct![index];
                return Container(
                  height: IZIDimensions.iziSize.height * 0.13,
                  width: IZIDimensions.iziSize.width * 0.8,
                  margin: EdgeInsets.only(
                    top: IZIDimensions.SPACE_SIZE_1X,
                  ),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
                      color: ColorResources.WHITE),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.gotoDetailFood(
                              controller.orderResponse.listProduct![index].id!);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              IZIDimensions.BORDER_RADIUS_3X),
                          child: IZIImage(
                            IZIValidate.nullOrEmpty(itemProduct.image)
                                ? ImagesPath.placeHolder
                                : itemProduct.image!.first!,
                            height: IZIDimensions.ONE_UNIT_SIZE * 140,
                            width: IZIDimensions.ONE_UNIT_SIZE * 140,
                          ),
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
                            Row(
                              children: [
                                Text(
                                  IZIValidate.nullOrEmpty(itemProduct.name)
                                      ? "không xác định"
                                      : itemProduct.name!,
                                  style: TextStyle(
                                    color: ColorResources.colorMain,
                                    fontFamily: NUNITO,
                                    fontWeight: FontWeight.w600,
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                  ),
                                ),
                                SizedBox(
                                  width: IZIDimensions.SPACE_SIZE_1X,
                                ),
                              ],
                            ),
                            Text(
                              "Số lượng : ${IZIValidate.nullOrEmpty(itemProduct.quantity) ? "không xác định" : itemProduct.quantity!}",
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
                                  "Giá tiền : ",
                                  style: TextStyle(
                                    color: ColorResources.GREY,
                                    fontFamily: NUNITO,
                                    fontWeight: FontWeight.w400,
                                    fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                                  ),
                                ),
                                if (itemProduct.priceDiscount == 0)
                                  Text(
                                    IZIValidate.nullOrEmpty(itemProduct.price)
                                        ? "không xác định"
                                        : IZIPrice.currencyConverterVND(
                                            itemProduct.price!.toDouble()),
                                    style: TextStyle(
                                      color: ColorResources.GREY,
                                      fontFamily: NUNITO,
                                      fontWeight: FontWeight.w400,
                                      decoration: itemProduct.priceDiscount != 0
                                          ? TextDecoration.lineThrough
                                          : null,
                                      fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                                    ),
                                  )
                                else
                                  Text(
                                    IZIPrice.currencyConverterVND(
                                        itemProduct.priceDiscount!.toDouble()),
                                    style: TextStyle(
                                      color: ColorResources.GREY,
                                      fontFamily: NUNITO,
                                      fontWeight: FontWeight.w400,
                                      fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                                    ),
                                  ),
                                Text(
                                  "vnđ",
                                  style: TextStyle(
                                    color: ColorResources.GREY,
                                    fontFamily: NUNITO,
                                    fontWeight: FontWeight.w400,
                                    fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                                  ),
                                )
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
          if (!IZIValidate.nullOrEmpty(controller.orderResponse.discount))
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Giảm giá: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        color: ColorResources.camNhat,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      IZIValidate.nullOrEmpty(controller.orderResponse.discount)
                          ? "Không xác định"
                          : "- " +
                              IZIPrice.currencyConverterVND(
                                  controller.orderResponse.discount!),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        color: ColorResources.camNhat,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_1X,
                ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Phí ship: ",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                  color: ColorResources.camNhat,
                ),
              ),
              const Spacer(),
              Text(
                IZIValidate.nullOrEmpty(controller.orderResponse.shipPrice)
                    ? "Không xác định"
                    : IZIPrice.currencyConverterVND(
                        controller.orderResponse.shipPrice!),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                  color: ColorResources.camNhat,
                ),
              ),
            ],
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
                IZIValidate.nullOrEmpty(controller.orderResponse.totalPrice)
                    ? "Không xác định"
                    : IZIPrice.currencyConverterVND(
                        controller.orderResponse.totalPrice!),
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
  Widget _inforDeliveryPerson(DetailOrderController controller) {
    return Container(
      height: IZIDimensions.iziSize.height * 0.18,
      width: IZIDimensions.iziSize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_4X,
        ),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Column(
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
                      IZIValidate.nullOrEmpty(controller.shipperResponse.avatar)
                          ? ImagesPath.placeHolder
                          : controller.shipperResponse.avatar!,
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
                            children: [
                              const TextSpan(
                                text: "Họ và tên: ",
                              ),
                              TextSpan(
                                text: IZIValidate.nullOrEmpty(
                                        controller.shipperResponse.fullName)
                                    ? "không xác định"
                                    : controller.shipperResponse.fullName!,
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
                            children: [
                              const TextSpan(
                                text: "Số điện thoại: ",
                              ),
                              TextSpan(
                                text: IZIValidate.nullOrEmpty(
                                        controller.shipperResponse.phone)
                                    ? "không xác định"
                                    : controller.shipperResponse.phone!,
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
                            children: [
                              const TextSpan(
                                text: "Biển số xe: ",
                              ),
                              TextSpan(
                                text: IZIValidate.nullOrEmpty(
                                        controller.shipperResponse.idVehicle)
                                    ? "không xác định"
                                    : controller.shipperResponse.idVehicle!,
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
          Positioned(
            top: 0,
            right: 0,
            child: controller.orderResponse.statusOrder == DELIVERING
                ? GestureDetector(
                    onTap: () {
                      controller.gotoCallPhone();
                    },
                    child: AvatarGlow(
                      glowColor: ColorResources.colorMain,
                      duration: const Duration(
                        milliseconds: 700,
                      ),
                      endRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
                      child: CircleAvatar(
                        backgroundColor: ColorResources.colorMain,
                        child: Icon(
                          Icons.phone,
                          color: ColorResources.WHITE,
                          size: IZIDimensions.ONE_UNIT_SIZE * 40,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }

  ///
  /// Infor Location Person.
  ///
  Widget _inforLocation(DetailOrderController controller) {
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
                    children: [
                      const TextSpan(
                        text: "Họ và tên: ",
                      ),
                      TextSpan(
                        text: IZIValidate.nullOrEmpty(
                                controller.orderResponse.name)
                            ? "Không xác định"
                            : controller.orderResponse.name!,
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
                    children: [
                      const TextSpan(
                        text: "Số điện thoại: ",
                      ),
                      TextSpan(
                        text: IZIValidate.nullOrEmpty(
                                controller.orderResponse.phone)
                            ? "Không xác định"
                            : controller.orderResponse.phone!,
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
                    children: [
                      const TextSpan(
                        text: "Địa chỉ: ",
                      ),
                      TextSpan(
                        text: IZIValidate.nullOrEmpty(
                                controller.orderResponse.address)
                            ? "Không xác định"
                            : controller.orderResponse.address!,
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
