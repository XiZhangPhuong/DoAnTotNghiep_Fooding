import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/cart/cart_request.dart';
import 'package:fooding_project/model/location/location_response.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/screens/dashboard/dashboard_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '../../base_widget/my_dialog_alert_done.dart';
import '../../repo/payment.dart';
import '../../repository/order_repository.dart';
import '../../routes/routes_path/location_routes.dart';

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
  LocationResponse location = LocationResponse();

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
        cartResponse = onSucces;
        isLoading = false;

        tamTinh();
        await findUser();
        await findLocation();
        update();
      },
      (e) {
        print(e.toString());
        print("hihi");
      },
    );
  }

  ///
  /// Find user.
  ///
  Future<void> findUser() async {
    isLoading = true;
    userResponse = await _userRepository.findUser();
    isLoading  = false;
  }

  ///
  /// Click plus.
  ///
  void onClickPlus(int index) async {
    EasyLoading.show(
      status: "Đang cập nhật dữ liệu",
    );
    cartResponse.listProduct![index].quantity =
        cartResponse.listProduct![index].quantity! + 1;
    await _orderResponsitory.updateCart(
      cartRquest: cartResponse,
    );
    EasyLoading.dismiss();
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
    EasyLoading.show(
      status: "Đang cập nhật dữ liệu",
    );
    cartResponse.listProduct![index].quantity =
        cartResponse.listProduct![index].quantity! - 1;
    await _orderResponsitory.updateCart(
      cartRquest: cartResponse,
    );
    EasyLoading.dismiss();
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
        final bot = Get.find<BottomBarController>();
        bot.countCartByIDStore();
        bot.update();
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

  ///
  /// To location.
  ///
  void gotoLocation() {
    Get.toNamed(LocationRoutes.LOCATION);
    // Navigator.push(
    //   Get.context!,
    //   MaterialPageRoute(
    //     builder: (context) => PlacePicker(
    //       apiKey: 'AIzaSyAHueeKcKT6RkTtgbKLI7qm-nza7mwldz4',
    //       region: 'VN',
    //       onPlacePicked: (result) async {
    //         print(
    //             "quyen test ${result.formattedAddress} lat ${result.geometry?.location.lat} lon ${result.geometry?.location.lng}");
    //         street = result.formattedAddress!;
    //         print("quyen test 1 ${street.contains("550000")}");
    //         Navigator.of(context).pop();
    //         // var response = await Dio().get(
    //         //     'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=40.659569,-73.933783&origins=40.6655101,-73.89188969999998&key=AIzaSyAHueeKcKT6RkTtgbKLI7qm-nza7mwldz4');
    //         // print(response);
    //         update();
    //       },
    //       initialPosition: const LatLng(16.0746543, 108.2202951),
    //       useCurrentLocation: true,
    //       resizeToAvoidBottomInset:
    //           false, // only works in page mode, less flickery, remove if wrong offsets
    //     ),
    //   ),
    // );
  }

  ///
  /// Find Location.
  ///
  Future<void> findLocation() async {
    if (!IZIValidate.nullOrEmpty(userResponse.idLocation)) {
      await _userRepository.finLocation(
        idLocation: userResponse.idLocation!,
        onSucces: (data) {
          location = data;
        },
        onError: (error) {
          print(error.toString());
        },
      );
    }
  }


  ///
  /// show notification 
  ///
  
}
