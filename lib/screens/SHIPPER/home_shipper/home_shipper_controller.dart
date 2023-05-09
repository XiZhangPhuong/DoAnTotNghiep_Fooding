// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

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
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../model/user.dart';

class HomeShipperController extends GetxController {
  bool isCheckOline = false;
  bool isLoadingUser = false;
  bool isLoadingOrder = false;
  bool isLoadingCustommer = false;
  String idUser = sl<SharedPreferenceHelper>().getIdUser;
  User? shipperReponse;
  User? custommerReponse;
  OrderResponse? orderResponse ;
  List<OrderResponse> listOrder = [];
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();
  final OrderResponsitory _orderResponsitory = GetIt.I.get<OrderResponsitory>();

  @override
  void onInit() {
    super.onInit();
    // get order
    getOrder();
    findUserShipper();
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
     custommerReponse =  await _userRepository.findbyId(idUser: idCustommer);
     isLoadingCustommer = true;
     update();
  }

  ///
  /// update status order
  ///
  Future<void> updateStatusOrder({required OrderResponse orderResponse}) async {
    _orderResponsitory.updateOrder(updatedOrder: orderResponse, onSuccess: (
       
    ) {
       
    }, onError: (e) {
       print(e);
    },);
  }

  ///
  /// click confirm
  ///
 void clickConfirm({required OrderResponse orderResponse}){
  EasyLoading.show(status: 'Đang cập nhập');
  if(orderResponse.statusOrder == PENDING){
    // đang giao
    orderResponse.statusOrder = DELIVERING;
    orderResponse.timeDelivering = DateFormat('HH:mm dd/MM/yyyy').format(DateTime.now());
    orderResponse.idEmployee = idUser;   
  } else if(orderResponse.statusOrder == DELIVERING){
    orderResponse.timeDone = DateFormat('HH:mm dd/MM/yyyy').format(DateTime.now()); 
    orderResponse.statusOrder = DONE;  
  }
  updateStatusOrder(orderResponse: orderResponse);
  EasyLoading.dismiss();
  IZIAlert().success(message: 'Cập nhập thành công');
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
    await  _orderResponsitory.getOrderListTen(onSuccess: (onSuccess) {
        listOrder = onSuccess;
        if(listOrder.isNotEmpty){
           orderResponse = listOrder.first;
        }
        print(listOrder.length.toString());
        isLoadingOrder = true;
        findUserCustomer(orderResponse!.idCustomer!);
        update();
     }, onError: (error) {
        print('Loi ${error}');
     },);
  }

  ///
/// price = price   * quantity
///
String priceProduct(int priceDiscount,int price){
  String str = '';
  if(priceDiscount==0){
    str =  IZIPrice.currencyConverterVND(price.toDouble(), 'vnđ');
  }else{
      str =  IZIPrice.currencyConverterVND(priceDiscount.toDouble(), 'vnđ');
  } 
  return str;
}


///
/// tam tinh
///
 double tamTinh({required List<Products> list}){
   double sum = 0;
   for(final i in list){
     if(i.priceDiscount==0){
      sum+=i.price!;
     }else{
      sum+=i.priceDiscount!;
     }
   }
   return sum ;
 }

 ///
 /// convert method pay
 ///
 String convertMethodPay({required String method}){
  String str = '';
  if(method=='CASH'){
    str = 'Tiền mặt';
  }else{
    str = 'Ví ZaloPay';
  }
  return str;

 }

}

