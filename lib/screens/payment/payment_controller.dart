import 'package:flutter/material.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:get/get.dart';

import '../../repo/payment.dart';

class PaymentController extends GetxController {
  String typePayment = CASH;
  List<String> listBenh = [
    'Răng-Hàm-Mặt',
    'Viêm xoan',
    'Khám thai',
    'Đau họng'
  ];
  String selectedBenh = "Răng-Hàm-Mặt";
  String zpTransToken = "", payResult = "";

  void setSelectedBenh(String value) {
    selectedBenh = value;
    update();
  }

  List<String> listImageSlider = [
    'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-2733-1655805928?w=600&amp;type=o&quot',
    'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-4898-1679481632?w=600&amp;type=o&quot',
    'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-4747-1676348590?w=600&amp;type=o&quot'
  ];

  @override
  void onInit() {
    super.onInit();
  }

  ///
  /// Thanh toán tiền mặt
  ///
  void clickPayCash() {
    typePayment = CASH;
    update();
  }

  ///
  /// Thanh toán Zalopay
  ///
  void clickPayBanking() {
    typePayment = BANKING;
    update();
  }

  ///
  /// Zalo pay.
  ///
  void payWithZaloPay() async {
    int amount = int.parse('123453');
    if (amount < 1000 || amount > 1000000) {
      zpTransToken = "Invalid Amount";
    } else {
      var result = await createOrder(amount);
      if (result != null) {
        zpTransToken = result.zptranstoken!;
      }
    }
    FlutterZaloPaySdk.payOrder(zpToken: zpTransToken).listen((event) {
      switch (event) {
        case FlutterZaloPayStatus.cancelled:
          payResult = "User Huỷ Thanh Toán";
          break;
        case FlutterZaloPayStatus.success:
          payResult = "Thanh toán thành công";
          Get.back();
          break;
        case FlutterZaloPayStatus.failed:
          payResult = "Thanh toán thất bại";
          break;
        default:
          payResult = "Thanh toán thất bại";
          break;
      }
    });
  }
}
