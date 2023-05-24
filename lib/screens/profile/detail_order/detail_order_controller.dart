// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/my_dialog_alert_done.dart';
import 'package:fooding_project/di_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/comment_repository.dart';
import 'package:fooding_project/repository/order_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/detail_food_routes.dart';
import 'package:fooding_project/routes/routes_path/detail_order_routes.dart';
import 'package:fooding_project/screens/home/home_controller.dart';
import 'package:fooding_project/routes/routes_path/profile_routes.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailOrderController extends GetxController {
  String idOrder = Get.arguments as String;

  final _orderRepository = GetIt.I.get<OrderResponsitory>();
  final _userResponsitory = GetIt.I.get<UserRepository>();
  final _commentRepository = GetIt.I.get<CommentRepository>();
  bool isLoading = true;
  bool checkComment = false;
  OrderResponse orderResponse = OrderResponse();

  // Create user.
  User shipperResponse = User();
  User storeResponse = User();
  User userResponse = User();
  @override
  void onInit() {
    super.onInit();
    findOrderDetail();
  }

  ///
  /// gotoDetailFood
  ///
  void gotoDetailFood(String id) {
    Get.find<HomeController>().gotoDetailFood(id);
  }

  ///
  /// check Comment
  ///
  bool checkCommentProduct({required String idProduct}) {
    bool hasComment = false;
    _commentRepository.checkComment(
      idUser: sl<SharedPreferenceHelper>().getIdUser,
      idProduct: idProduct,
      onSuccess: (check) {
        print(check);
        update();
        hasComment = check;
      },
      onError: (e) {
        print(e);
      },
    );
    return hasComment;
  }

  ///
  /// go to evualate
  ///
  void gotoEvaluate(String idOrder, String idProduct) {
    Get.toNamed(DetailOrderRoutes.EVALUATE, arguments: [idOrder, idProduct]);
  }

  ///
  /// find order detail.
  ///
  void findOrderDetail() {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(idOrder)
        .snapshots()
        .listen((event) async {
      if (event.exists) {
        orderResponse =
            OrderResponse.fromMap(event.data() as Map<String, dynamic>);
        isLoading = false;
        await findDeliveryMan();
        await findStore(orderResponse.listProduct!.first.idUser!);
        update();
      } else {
        isLoading = false;
        update();
      }
    });
  }

  ///
  /// Find Delivery man.
  ///
  Future<void> findDeliveryMan() async {
    try {
      shipperResponse =
          await _userResponsitory.findbyId(idUser: orderResponse.idEmployee!);
    } catch (e) {
      print(e.toString());
    }
  }

  ///
  /// Find Store.
  ///
  Future<void> findStore(String idStore) async {
    await _userResponsitory.findStoreByID(
      idStore: idStore,
      onSucces: (store) {
        storeResponse = store;
      },
      onError: (error) {
        print(error.toString());
      },
    );
  }

  ///
  /// Go to Shop.
  ///
  void goToShop() {
    Get.toNamed(DetailtFoodRoutes.STORE, arguments: storeResponse.id!);
  }

  ///
  /// void goto GG map
  ///
  void gotoGoogleMapMaker() {
    if (!IZIValidate.nullOrEmpty(orderResponse.idEmployee)) {
      Get.toNamed(ProfileRoutes.GG_MAP_MARKER, arguments: [
        storeResponse.id!,
        orderResponse.idEmployee!,
      ]);
    } else {
      IZIAlert().success(message: "Chưa có người nhận hàng");
    }
  }

  ///
  /// Handle type order.
  ///
  void handleTypeOrder() {
    switch (orderResponse.statusOrder) {
      case PENDING:
        handleCancleOrder();
        break;
      case DELIVERING:
        gotoGoogleMapMaker();
        break;
      case DONE:
        break;
      default:
    }
  }

  ///
  /// Handle cancle order.
  ///
  void handleCancleOrder() {
    Get.dialog(
      DialogCustom(
        description: "Bạn có chắc chắn hủy đơn hàng không?",
        agree: "Đồng ý",
        cancel1: "Hủy",
        onTapCancle: () {
          Get.back();
        },
        onTapConfirm: () async {
          await _orderRepository.updateOrder(
            idOrder: idOrder,
            orderResponse: OrderResponse(statusOrder: "CANCEL"),
            onSuccess: () async {
              IZIAlert().success(message: "Hủy đơn hàng thành công");
              if (orderResponse.idVoucher != null) {
                await FirebaseFirestore.instance
                    .collection("vouchers")
                    .doc(orderResponse.idVoucher)
                    .update({
                  "listCustomer": FieldValue.arrayRemove(
                      [sl<SharedPreferenceHelper>().getIdUser])
                });
              }
              Get.back();
              Get.back(result: SUCCESS);
            },
            onError: (erorr) {
              print(erorr.toString());
            },
          );
        },
      ),
    );
  }

  ///
  /// Call phone.
  ///
  Future<void> gotoCallPhone() async {
    if (!IZIValidate.nullOrEmpty(shipperResponse.phone)) {
      final Uri launchUri = Uri(scheme: 'tel', path: shipperResponse.phone!);

      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        IZIAlert().error(message: "Wrong phone number");
      }
    } else {
      IZIAlert().error(message: "Vui lòng thử lại sau");
    }
  }
}
