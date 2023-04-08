import 'package:flutter/material.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/screens/payment/payment_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
import 'package:get/get.dart';

class PaymentPage extends GetView<PaymentController> {
 
const PaymentPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PaymentController(),
      builder: ( PaymentController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACK_GROUND,
          appBar: _appBar(),
        );
      },
    );
  }
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
