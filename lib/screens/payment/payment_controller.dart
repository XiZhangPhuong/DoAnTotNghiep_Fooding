import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/cart/cart_request.dart';
import 'package:fooding_project/model/location/location_response.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_webservice/distance.dart';

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
  double? distance;
  double? priceShip;
  //DistanceResponse? distance;
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
    userResponse = await _userRepository.findUser();
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
    Get.toNamed(LocationRoutes.LOCATION)?.then((value) async {
      await findUser();
      await findLocation();
      update();
    });
  }

  ///
  /// Find Location.
  ///
  Future<void> findLocation() async {
    if (!IZIValidate.nullOrEmpty(userResponse.idLocation)) {
      await _userRepository.finLocation(
        idLocation: userResponse.idLocation!,
        onSucces: (data) async {
          if (!IZIValidate.nullOrEmpty(data)) {
            location = data;
            List<String> listLatLong = location.latlong!.split(";");
            var response = await Dio().get(
                'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=16.0718593,108.2206474&origins=${listLatLong[0]},${listLatLong[1]}&key=AIzaSyDyrOV7FyJZqv4i9sUOrmircCLfnDI5RaI');
            // distanceLocation = DistanceResponse.fromJson(
            //     response.data as Map<String, dynamic>);
            print(response);
            print(
                "${listLatLong[0].toString()} ho ho${listLatLong[1].toString()}");
            distance = (Geolocator.distanceBetween(
                      16.0718593,
                      108.2206474,
                      double.parse(listLatLong[0].toString()),
                      double.parse(listLatLong[1].toString()),
                    ) /
                    1000)
                .toPrecision(2);
            priceShip = distance! * 10000;
          }
        },
        onError: (error) {
          print(error.toString());
        },
      );
    }
  }

  ///
  /// On click pay.
  ///
  void onClickPay() async {
    if (handleValidate()) {
      print("123");
    }
  }

  ///
  /// Handle validate.
  ///
  bool handleValidate() {
    if (IZIValidate.nullOrEmpty(distance)) {
      IZIAlert().error(message: "Vui lòng chọn địa chỉ");
      return false;
    }
    if (IZIValidate.nullOrEmpty(location)) {
      IZIAlert().error(message: "Vui lòng chọn địa chỉ");
      return false;
    }
    return true;
  }
}
