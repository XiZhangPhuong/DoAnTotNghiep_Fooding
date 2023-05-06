import 'package:dio/dio.dart';
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
import 'package:fooding_project/model/voucher/voucher.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/cart_routes.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/screens/dashboard/dashboard_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_webservice/distance.dart';
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
  Voucher? myVourcher;

  TextEditingController noteEditingController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    noteEditingController.dispose();
    descriptionController.dispose();
  }

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
        if (!IZIValidate.nullOrEmpty(onSucces.idUser)) {
          cartResponse = onSucces;
          tamTinh();
          await findUser();
          await findLocation();
        }

        isLoading = false;
        update();
      },
      (e) {
        print(e.toString());
        isLoading = false;
        update();
      },
    );
  }

  ///
  /// Find user.
  ///
  Future<void> findUser() async {
    isLoading = true;
    userResponse = await _userRepository.findUser();
    isLoading = false;
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
  void clickDelete(int index) async {
    bool flag = false;
    await Get.dialog(DialogCustom(
      description: 'Bạn có muốn xóa món này không?',
      agree: 'Có',
      cancel1: 'Không',
      onTapConfirm: () {
        flag = true;
        Get.back();
      },
      onTapCancle: () {
        flag = false;
        Get.back();
      },
    ));
    if (flag) {
      EasyLoading.show(status: "Đang cập nhật dữ liệu");
      cartResponse.listProduct!.removeAt(index);
      if (cartResponse.listProduct!.isEmpty) {
        await _orderResponsitory.deleteCart();
        distance = null;
        tamTinh();
        update();
      } else {
        await _orderResponsitory.updateCart(cartRquest: cartResponse);
        tamTinh();
        update();
      }
      final bot = Get.find<BottomBarController>();
      bot.countCartByIDStore();
      bot.update();

      EasyLoading.dismiss();
    }
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
            // distance = (Geolocator.distanceBetween(
            //           16.0718593,
            //           108.2206474,
            //           double.parse(listLatLong[0].toString()),
            //           double.parse(listLatLong[1].toString()),
            //         ) /
            //         1000)
            //     .toPrecision(2);
            var response = await Dio().get(
                'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${listLatLong[0].toString()},${listLatLong[1].toString()}&origins=16.0718593,108.2206474&key=AIzaSyB1KM0R3xVa8P0_VvMQah-F16OFrIYORs8');
            DistanceResponse distanceResponse = DistanceResponse.fromJson(
                response.data as Map<String, dynamic>);
            distance = double.parse(distanceResponse
                .rows[0].elements[0].distance.text
                .split(' ')[0]);
            priceShip = distance! * 10000;
            update();
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
        if (!IZIValidate.nullOrEmpty(myVourcher)) {
          order.discount = myVourcher!.discountMoney.toString();
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
        order.note = descriptionController.text.trim();
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
    if (IZIValidate.nullOrEmpty(cartResponse.listProduct)) {
      IZIAlert().error(message: "Hiện tại chưa có món nào trong giỏ hàng");
      return false;
    }
    return true;
  }

  ///
  /// Go to Voucher.
  ///
  void goToVoucher() {
    Get.toNamed(CartRoutes.VOUCHER, arguments: tamtinh)?.then((value) {
      if (!IZIValidate.nullOrEmpty(value)) {
        myVourcher = value as Voucher;
        totalPay();
        update();
      }
    });
  }

  ///
  /// Total Pay.
  ///
  double totalPay() {
    double discount = 0;
    if (!IZIValidate.nullOrEmpty(myVourcher)) {
      discount = myVourcher!.discountMoney!.toDouble();
    }
    return priceShip + tamtinh - discount <= 0
        ? 0
        : priceShip + tamtinh - discount;
  }

  ///
  /// show notification
  ///
}
