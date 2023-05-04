import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_image.dart';
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
          return GestureDetector(
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
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          height: IZIDimensions.ONE_UNIT_SIZE * 200,
                          margin: EdgeInsets.all(
                            IZIDimensions.SPACE_SIZE_1X,
                          ),
                          padding: EdgeInsets.all(
                            IZIDimensions.SPACE_SIZE_1X * 0.5,
                          ),
                          color: Colors.white,
                          child: Row(
                            children: [
                              SizedBox(
                                height: IZIDimensions.ONE_UNIT_SIZE * 200,
                                width: IZIDimensions.ONE_UNIT_SIZE * 180,
                                child: IZIImage(
                                  ImagesPath.placeHolder,
                                ),
                              ),
                              SizedBox(
                                width: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Miễn phí vận chuyển",
                                      style: TextStyle(
                                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                        fontWeight: FontWeight.w500,
                                        color: ColorResources.BLACK,
                                      ),
                                    ),
                                    Text(
                                      "Đơn tối thiểu: 0 vnđ",
                                      style: TextStyle(
                                        fontSize:
                                            IZIDimensions.FONT_SIZE_SPAN * 0.8,
                                        fontWeight: FontWeight.w500,
                                        color: ColorResources.BLACK,
                                      ),
                                    ),
                                    Text(
                                      "Ngày hết hạn: 23/10/2023",
                                      style: TextStyle(
                                        fontSize:
                                            IZIDimensions.FONT_SIZE_SPAN * 0.8,
                                        fontWeight: FontWeight.w500,
                                        color: ColorResources.BLACK,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
                            ontap: () {},
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
            onPressed: () {},
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
