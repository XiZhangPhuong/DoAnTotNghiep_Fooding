
// ignore_for_file: avoid_print

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/order_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class HomeShipperController extends GetxController {
  bool isCheckOline = false;
  bool isLoadingUser = false;
  bool isLoadingOrder = false;
  String idUser = sl<SharedPreferenceHelper>().getIdUser;
  User? shipperReponse;
  OrderResponse? orderResponse;
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();
  final OrderResponsitory _orderResponsitory = GetIt.I.get<OrderResponsitory>();

  @override
  void onInit() {
    super.onInit();
    // get order
    getOrder();
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
  Future<void> findUser() async {
    shipperReponse = await _userRepository.findUser();
    isLoadingUser = true;
    print(shipperReponse);
    update();
  }

  ///
  /// Update User
  ///
  Future<void> updateAccount() async {
    try {
      EasyLoading.show(status: "Đang cập nhật dữ liệu...");
      final User user = User();
      user.isOline = isCheckOline;
      await _userRepository
          .updateUser(user, sl<SharedPreferenceHelper>().getIdUser);
      EasyLoading.dismiss();
      Get.back();
      IZIAlert().success(message: 
      isCheckOline ? 'Bạn đã bật hoạt động' : 'Bạn đã tắt hoạt động'
      );
    } catch (e) {
      IZIAlert().error(message: e.toString());
      EasyLoading.dismiss();
    }
  }


  ///
  /// get order
  ///
  Future<void> getOrder() async {
     _orderResponsitory.getOrderListTen(onSuccess: (onSuccess) {
        orderResponse = onSuccess;
        print(orderResponse!.toMap());
        isLoadingOrder = true;
        update();
     }, onError: (error) {
        print(error);
     },);
  }
}
