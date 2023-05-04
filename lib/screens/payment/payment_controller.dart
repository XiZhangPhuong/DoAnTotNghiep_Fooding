import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_date.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/cart/cart_request.dart';
import 'package:fooding_project/model/location/location_response.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/cart_routes.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import '../../base_widget/my_dialog_alert_done.dart';
import '../../model/order/order.dart';
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
  double priceShip = 0;
  bool flagSpam = true;
  double? myVourcher;

  TextEditingController noteEditingController = TextEditingController();
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
  void payWithZaloPay(String price, OrderResponse order) async {
    int amount = int.parse(price);
    if (amount < 1000 || amount > 1000000) {
      zpTransToken = "Invalid Amount";
    } else {
      var result = await createOrder(amount);
      if (result != null) {
        zpTransToken = result.zptranstoken!;
      }
    }
    FlutterZaloPaySdk.payOrder(zpToken: zpTransToken).listen((event) async {
      switch (event) {
        case FlutterZaloPayStatus.cancelled:
          payResult = "User Huỷ Thanh Toán";
          EasyLoading.dismiss();
          IZIAlert().error(message: "Bạn đã hủy thanh toán");
          break;
        case FlutterZaloPayStatus.success:
          payResult = "Thanh toán thành công";
          await _orderResponsitory.addOrder(
            orderRequest: order,
            onSucces: () async {
              await _orderResponsitory.deleteCart();
              flagSpam = true;
            },
            onError: (e) {
              IZIAlert().error(message: e.toString());
            },
          );
          Get.back();
          EasyLoading.dismiss();
          IZIAlert().success(message: "Đặt hàng thành công");
          break;
        case FlutterZaloPayStatus.failed:
          payResult = "Thanh toán thất bại";
          EasyLoading.dismiss();
          IZIAlert().error(message: "Vui lòng thử lại sau");
          break;
        default:
          payResult = "Thanh toán thất bại";
          EasyLoading.dismiss();
          IZIAlert().error(message: "Vui lòng thử lại sau");
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
        if (cartResponse.listProduct!.isEmpty) {
          await _orderResponsitory.deleteCart();
          Get.back();
          distance = null;
          tamTinh();
          update();
        } else {
          await _orderResponsitory.updateCart(cartRquest: cartResponse);
          Get.back();
          tamTinh();
          update();
        }
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
      if (flagSpam) {
        flagSpam = false;
        EasyLoading.show(status: "Đang cập nhật dữ liệu");
        OrderResponse order = OrderResponse();
        order.id = const Uuid().v1();
        order.address = location.address;
        order.phone = location.phone;
        if (IZIValidate.nullOrEmpty(myVourcher)) {
          order.discount = myVourcher.toString();
        }
        order.listProduct = cartResponse.listProduct;
        order.idCustomer = sl<SharedPreferenceHelper>().getIdUser;
        order.latLong = location.latlong;
        order.note = noteEditingController.text;
        order.shipPrice = priceShip.toString();
        order.typePayment = typePayment;
        order.timeOrder =
            IZIDate.formatDate(DateTime.now(), format: "HH:mm dd/MM/yyyy");
        order.statusOrder = "PENDING";
        order.totalPrice = totalPay().toInt().toString();
        if (typePayment == CASH) {
          await _orderResponsitory.addOrder(
            orderRequest: order,
            onSucces: () async {
              await _orderResponsitory.deleteCart();
              flagSpam = true;
            },
            onError: (e) {
              IZIAlert().error(message: e.toString());
            },
          );
          IZIAlert().success(message: "Đặt hàng thành công");
          EasyLoading.dismiss();
          Get.back();
        } else {
          payWithZaloPay(totalPay().toInt().toString(), order);
        }
      }
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

  ///
  /// Go to Voucher.
  ///
  void goToVoucher() {
    Get.toNamed(CartRoutes.VOUCHER);
  }

  ///
  /// Total Pay.
  ///
  double totalPay() {
    return priceShip + tamtinh;
  }
}
