// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/repository/order_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/fcmNotification.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import '../../../model/user.dart';

class HomeShipperController extends GetxController {
  bool isCheckOline = false;
  bool isLoadingUser = false;
  bool isLoadingOrder = false;
  bool isLoadingCustommer = false;
  String idUser = sl<SharedPreferenceHelper>().getIdUser;
  User? shipperReponse;
  User? custommerReponse;
  OrderResponse? orderResponse;
  List<OrderResponse> listOrder = [];
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();
  final OrderResponsitory _orderResponsitory = GetIt.I.get<OrderResponsitory>();

  /// Declare time
  Timer? _timer;
  int dem = 0;
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  StreamSubscription<Position>? positionStream;
  Position? currentPostion;

  String statusOrder = 'Nhận đơn';
  @override
  void onInit() {
    super.onInit();
    // get order
    getOrder();
    findUserShipper();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
    if (positionStream != null) {
      positionStream!.cancel();
    }
  }

  ///
  /// check oline
  ///
  void clickTickOline() {
    isCheckOline = !isCheckOline;
    updateAccount();
    update();
  }

  ///
  /// Find user.
  ///
  Future<void> findUserShipper() async {
    shipperReponse = await _userRepository.findUser();
    isLoadingUser = true;
    print(shipperReponse);
    update();
  }

  ///
  /// Find user.
  ///
  Future<void> findUserCustomer(String idCustommer) async {
    custommerReponse = await _userRepository.findbyId(idUser: idCustommer);
    isLoadingCustommer = true;
    update();
  }

  ///
  /// update status order
  ///
  Future<void> updateStatusOrder({required OrderResponse orderResponse}) async {
    _orderResponsitory.updateOrder(
      updatedOrder: orderResponse,
      onSuccess: () {
        IZIAlert().success(message: "Đã cập nhật dữ liệu");
      },
      onError: (e) {
        print(e);
      },
    );
  }

  ///
  /// click confirm
  ///
  Future<void> clickConfirm() async {
    EasyLoading.show(status: 'Đang cập nhập');
    if (orderResponse!.statusOrder == PENDING) {
      startTimer();
      orderResponse!.statusOrder = DELIVERING;
      orderResponse!.idEmployee = idUser;
      updateStatusOrder(orderResponse: orderResponse!);
      FcmNotification.sendNotification(
          token: custommerReponse!.deviceId!,
          body: "Đơn hàng của bạn đã được nhận bởi tài xế",
          title: "Đơn hàng bạn đã được nhận");
      statusOrder = "xác nhân đến quán";
      update();
    } else if (orderResponse!.statusOrder == DELIVERING) {
      if (IZIValidate.nullOrEmpty(orderResponse!.timeConfirm)) {
        orderResponse!.timeConfirm =
            DateFormat('HH:mm dd/MM/yyyy').format(DateTime.now());
        updateStatusOrder(orderResponse: orderResponse!);
        FcmNotification.sendNotification(
            token: custommerReponse!.deviceId!,
            body:
                "Tài xế đã tới quán của bạn để xem thông tin chi tiết vào trạng thái đơn hàng ",
            title: "Tài xế đã đến quán ăn");
        statusOrder = "Giao hàng";
        update();
      } else if (IZIValidate.nullOrEmpty(orderResponse!.timeDelivering)) {
        // đang giao
        orderResponse!.timeDelivering =
            DateFormat('HH:mm dd/MM/yyyy').format(DateTime.now());

        await updateStatusOrder(orderResponse: orderResponse!);
        FcmNotification.sendNotification(
            token: custommerReponse!.deviceId!,
            body: "Tài xế nhận được món ăn và đang vận chuyển",
            title: "Tài xế đã nhận đơn hàng");
        statusOrder = "Thành công";
        update();
      } else if (IZIValidate.nullOrEmpty(orderResponse!.timeDone)) {
        if (_timer != null) {
          _timer!.cancel();
        }
        orderResponse!.statusOrder = DONE;
        orderResponse!.timeDone =
            DateFormat('HH:mm dd/MM/yyyy').format(DateTime.now());
        await updateStatusOrder(orderResponse: orderResponse!);
        FcmNotification.sendNotification(
            token: custommerReponse!.deviceId!,
            body: "Tài xế đã giao hàng thành công",
            title: "Giao hàng thành công");
        statusOrder = 'Nhận đơn';
        isLoadingUser = false;
        isLoadingOrder = false;
        isLoadingCustommer = false;
        orderResponse = null;
        update();
      }
    }

    EasyLoading.dismiss();
  }

  ///
  /// Update User
  ///
  Future<void> updateAccount() async {
    try {
      EasyLoading.show(status: "Đang cập nhật dữ liệu...");
      final User user = User();
      user.isOline = isCheckOline;
      await _userRepository.updateUser(
          user, sl<SharedPreferenceHelper>().getIdUser);
      EasyLoading.dismiss();
      Get.back();
      IZIAlert().success(
          message:
              isCheckOline ? 'Bạn đã bật hoạt động' : 'Bạn đã tắt hoạt động');
    } catch (e) {
      IZIAlert().error(message: e.toString());
      EasyLoading.dismiss();
    }
  }

  ///
  /// get order
  ///
  Future<void> getOrder() async {
    FirebaseFirestore.instance
        .collection("orders")
        .snapshots(includeMetadataChanges: true)
        .listen((event) async {
      if (event.docChanges.isNotEmpty) {
        print(event.docChanges.first.doc.data().toString());
        if (orderResponse == null) {
          for (final doc in event.docChanges) {
            final order =
                OrderResponse.fromMap(doc.doc.data() as Map<String, dynamic>);
            if (order.statusOrder != DONE) {
              if (order.statusOrder != CANCEL) {
                orderResponse = order;
                if (!IZIValidate.nullOrEmpty(orderResponse!.idEmployee)) {
                  if (orderResponse!.idEmployee ==
                          sl<SharedPreferenceHelper>().getIdUser &&
                      orderResponse!.statusOrder == DELIVERING) {
                    print(orderResponse!.toJson());
                    await findUserCustomer(orderResponse!.idCustomer!);
                    isLoadingOrder = true;
                    update();
                    break;
                  }
                }
                if (orderResponse!.idEmployee !=
                        sl<SharedPreferenceHelper>().getIdUser &&
                    orderResponse!.statusOrder == DELIVERING) {
                  isLoadingUser = false;
                  isLoadingOrder = false;
                  isLoadingCustommer = false;
                  orderResponse = null;
                  update();
                  continue;
                }
                if (IZIValidate.nullOrEmpty(orderResponse!.idEmployee) &&
                    orderResponse!.statusOrder == PENDING) {
                  print(orderResponse!.toJson());
                  await findUserCustomer(orderResponse!.idCustomer!);
                  isLoadingOrder = true;
                  update();
                  break;
                }
              }
            }
          }
        }
      } else {
        print("No data change");
        isLoadingOrder = true;
        update();
      }
    });
  }

  ///
  /// price = price   * quantity
  ///
  String priceProduct(int priceDiscount, int price) {
    String str = '';
    if (priceDiscount == 0) {
      str = IZIPrice.currencyConverterVND(price.toDouble(), 'vnđ');
    } else {
      str = IZIPrice.currencyConverterVND(priceDiscount.toDouble(), 'vnđ');
    }
    return str;
  }

  ///
  /// tam tinh
  ///
  double tamTinh({required List<Products> list}) {
    double sum = 0;
    for (final i in list) {
      if (i.priceDiscount == 0) {
        sum += i.price!;
      } else {
        sum += i.priceDiscount!;
      }
    }
    return sum;
  }

  ///
  /// convert method pay
  ///
  String convertMethodPay({required String method}) {
    String str = '';
    if (method == 'CASH') {
      str = 'Tiền mặt';
    } else {
      str = 'Ví ZaloPay';
    }
    return str;
  }

  void startTimer() {
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      currentPostion = position;
    });
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) async {
      if (dem == 20) {
        if (!IZIValidate.nullOrEmpty(currentPostion)) {
          User request = User();
          request.latLong =
              "${currentPostion!.latitude};${currentPostion!.longitude}";
          await _userRepository.updateUser(
              request, sl<SharedPreferenceHelper>().getIdUser);
        }
        dem = 0;
      } else {
        print("quyen test 2 $dem");

        dem++;
      }
    });
  }

  ///
  /// Get current location.
  ///
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    bool isGetLocation = true;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      //
      // Disable get location.
      isGetLocation = false;
      await Geolocator.requestPermission().then((LocationPermission value) {
        if (value == LocationPermission.always ||
            value == LocationPermission.whileInUse) {
          //
          // Enable get location.
          isGetLocation = true;
        }
      });
    } else if (permission == LocationPermission.deniedForever) {
      //
      // Disable get location.
      isGetLocation = false;

      // Show dialog get location.
      //return showDialogGetPermissionLocation().then((value) => null);
    }

    if (isGetLocation) {
      await Geolocator.getCurrentPosition().then((value) {
        currentPostion = value;
        update();
      });
    }
  }
}
