import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/cart/cart_request.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../base_widget/my_dialog_alert_done.dart';
import '../../repo/payment.dart';
import '../../repository/order_repository.dart';

class PaymentController extends GetxController {
  //
  // Declare API
  final OrderResponsitory _orderResponsitory = GetIt.I.get<OrderResponsitory>();
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();

  // Init value.
  String typePayment = CASH;
  String zpTransToken = "", payResult = "";
  bool isLoading = false;
  double tamtinh = 0.0;

  CartRquest cartResponse = CartRquest();
  User userResponse = User();
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
      (onSucces) async {
        if (!IZIValidate.nullOrEmpty(onSucces.listProduct)) {
          cartResponse = onSucces;
          isLoading = false;
        }
        tamTinh();
        await findUser();
        update();
      },
      (e) {
        print(e.toString());
      },
    );
  }

  ///
  /// Find user.
  ///
  Future<void> findUser() async {
    userResponse = await _userRepository.findUser();
  }

  ///
  /// Click plus.
  ///
  void onClickPlus(int index) async {
    cartResponse.listProduct![index].quantity =
        cartResponse.listProduct![index].quantity! + 1;
    await _orderResponsitory.updateCart(
      cartRquest: cartResponse,
    );
    tamTinh();
    update();
  }

  ///
  /// Click minus.
  ///
  Future<void> onClickMinus(int index) async {
    if (cartResponse.listProduct![index].quantity == 1) {
      clickDelete(index);
      return;
    }
    cartResponse.listProduct![index].quantity =
        cartResponse.listProduct![index].quantity! - 1;
    await _orderResponsitory.updateCart(
      cartRquest: cartResponse,
    );
    tamTinh();
    update();
  }

  ///
  /// Click delete.
  ///
  void clickDelete(int index) {
    Get.dialog(DialogCustom(
      description: 'Bạn có muốn xóa món này không?',
      agree: 'Có',
      cancel1: 'Không',
      onTapConfirm: () async {
        cartResponse.listProduct!.removeAt(index);
        await _orderResponsitory.updateCart(cartRquest: cartResponse);
        Get.back();
        tamTinh();
        update();
      },
      onTapCancle: () {
        Get.back();
      },
    ));
  }

  ///
  /// Tam tinh.
  ///
  void tamTinh() async {
    tamtinh = 0;
    if (!IZIValidate.nullOrEmpty(cartResponse.listProduct)) {
      for (final element in cartResponse.listProduct!) {
        tamtinh += element.price! * element.quantity!;
      }
    }
  }
}
