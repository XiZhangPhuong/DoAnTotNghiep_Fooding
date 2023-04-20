import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/cart/cart_request.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../repo/payment.dart';
import '../../repository/order_repository.dart';

class PaymentController extends GetxController {
  //
  // Declare API
  OrderResponsitory _orderResponsitory = GetIt.I.get<OrderResponsitory>();

  // Init value.
  String typePayment = CASH;
  String zpTransToken = "", payResult = "";
  bool isLoading = false;

  CartRquest cartResponse = CartRquest();
  @override
  void onInit() {
    super.onInit();
    getAllCart();
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

  ///
  /// Get all order.
  ///
  void getAllCart() {
    isLoading = true;
    _orderResponsitory.getCart(
      (onSucces) {
        if (!IZIValidate.nullOrEmpty(onSucces.listProduct)) {
          cartResponse = onSucces;
          isLoading = false;
          update();
        }
      },
      (e) {
        print(e.toString());
      },
    );
  }
}
