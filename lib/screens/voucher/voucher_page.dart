import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
import 'package:fooding_project/base_widget/izi_loading_card.dart';
import 'package:fooding_project/base_widget/izi_smart_refresher.dart';
import 'package:fooding_project/helper/izi_date.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/screens/voucher/voucher_controller.dart';
import 'package:fooding_project/screens/widgets/app_bar.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';

import '../../helper/izi_dimensions.dart';
import '../components/button_app.dart';

class VoucherPage extends GetView {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFooding(title: "Voucher của bạn"),
      body: GetBuilder(
        init: VoucherController(),
        builder: (VoucherController controller) {
          return controller.isLoading
              ? const Center(
                  child: CardLoadingItem(
                    count: 10,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: SizedBox(
                    height: IZIDimensions.iziSize.height,
                    width: IZIDimensions.iziSize.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        _inputVoucher(controller),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        const Divider(
                          height: 2,
                          color: ColorResources.colorMain,
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        Expanded(
                          child: IZISmartRefresher(
                            refreshController: controller.refreshController,
                            onRefresh: () {
                              controller.getAllVoucher();
                            },
                            onLoading: () {},
                            enablePullUp: true,
                            enablePullDown: true,
                            child: ListView.builder(
                              itemCount: controller.listVouchers.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (controller.index == index) {
                                      controller.index = -1;
                                      controller.update();
                                    } else {
                                      controller.index = index;
                                      controller.update();
                                    }
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height:
                                            IZIDimensions.ONE_UNIT_SIZE * 200,
                                        margin: EdgeInsets.all(
                                          IZIDimensions.SPACE_SIZE_1X,
                                        ),
                                        padding: EdgeInsets.all(
                                          IZIDimensions.SPACE_SIZE_1X * 0.5,
                                        ),
                                        color: controller.index == index
                                            ? const Color(0xfff99b7d)
                                            : Colors.white,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height:
                                                  IZIDimensions.ONE_UNIT_SIZE *
                                                      200,
                                              width:
                                                  IZIDimensions.ONE_UNIT_SIZE *
                                                      180,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  IZIDimensions
                                                      .BORDER_RADIUS_4X,
                                                ),
                                                child: IZIImage(
                                                  IZIValidate.nullOrEmpty(
                                                          controller
                                                              .listVouchers[
                                                                  index]
                                                              .image)
                                                      ? ImagesPath.placeHolder
                                                      : controller
                                                          .listVouchers[index]
                                                          .image!,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  IZIDimensions.SPACE_SIZE_2X,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    height: IZIDimensions
                                                        .SPACE_SIZE_1X,
                                                  ),
                                                  Text(
                                                    IZIValidate.nullOrEmpty(
                                                            controller
                                                                .listVouchers[
                                                                    index]
                                                                .name)
                                                        ? "Không xác định"
                                                        : controller
                                                            .listVouchers[index]
                                                            .name!,
                                                    style: TextStyle(
                                                      fontSize: IZIDimensions
                                                          .FONT_SIZE_SPAN,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: ColorResources
                                                          .colorMain,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Đơn tối thiểu: ${IZIValidate.nullOrEmpty(controller.listVouchers[index].minOrderPrice) ? "Không xác định" : IZIPrice.currencyConverterVND(double.parse(controller.listVouchers[index].minOrderPrice.toString()))}vnđ",
                                                    style: TextStyle(
                                                      fontSize: IZIDimensions
                                                              .FONT_SIZE_SPAN *
                                                          0.8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          ColorResources.BLACK,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Giảm giá: ${IZIValidate.nullOrEmpty(controller.listVouchers[index].discountMoney) ? "Không xác định" : IZIPrice.currencyConverterVND(double.parse(controller.listVouchers[index].discountMoney.toString()))}vnđ",
                                                    style: TextStyle(
                                                      fontSize: IZIDimensions
                                                              .FONT_SIZE_SPAN *
                                                          0.8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          ColorResources.BLACK,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Ngày hết hạn: ${IZIValidate.nullOrEmpty(controller.listVouchers[index].endDate) ? "Không xác định" : IZIDate.formatDate(controller.listVouchers[index].endDate!, format: "HH:mm dd/MM/yyy")}",
                                                    style: TextStyle(
                                                      fontSize: IZIDimensions
                                                              .FONT_SIZE_SPAN *
                                                          0.8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          ColorResources.BLACK,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        right: IZIDimensions.ONE_UNIT_SIZE * 20,
                                        top: IZIDimensions.ONE_UNIT_SIZE * 30,
                                        child: const Text(
                                          "Xem thêm",
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
      bottomSheet: GetBuilder(
        builder: (VoucherController controller) =>
            MediaQuery.of(context).viewInsets.bottom > 0
                ? const SizedBox()
                : controller.isLoading
                    ? const SizedBox()
                    : Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        width: IZIDimensions.iziSize.width,
                        height: IZIDimensions.ONE_UNIT_SIZE * 90,
                        child: Center(
                          child: ButtonFooding(
                            text: "Đồng ý",
                            ontap: () {
                              controller.onClickListView(controller.index);
                            },
                            border: IZIDimensions.BORDER_RADIUS_4X,
                          ),
                        ),
                      ),
      ),
    );
  }

  SizedBox _inputVoucher(VoucherController controller) {
    return SizedBox(
      width: IZIDimensions.iziSize.width,
      height: IZIDimensions.iziSize.height * 0.06,
      child: Row(
        children: [
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_2X,
          ),
          Expanded(
            child: TextFormField(
              controller: controller.textvoucher,
              decoration: InputDecoration(
                hintText: "Nhập mã giảm giá",
                hintStyle: TextStyle(
                  color: ColorResources.GREY,
                  fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_2X,
          ),
          ElevatedButton(
            onPressed: () {
              controller.findcodeVoucher();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorResources.colorMain,
              padding: EdgeInsets.all(
                IZIDimensions.SPACE_SIZE_2X,
              ),
              textStyle: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Center(
              child: Text(
                "Áp dụng",
              ),
            ),
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_1X,
          ),
        ],
      ),
    );
  }
}
