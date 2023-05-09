import 'package:flutter/material.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/comment_repository.dart';
import 'package:fooding_project/repository/order_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/detail_food_routes.dart';
import 'package:fooding_project/routes/routes_path/detail_order_routes.dart';
import 'package:fooding_project/screens/home/home_controller.dart';
import 'package:fooding_project/routes/routes_path/profile_routes.dart';
import 'package:fooding_project/screens/profile/google_map_marker/google_map_marker_page.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';


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
  bool checkCommentProduct({required String idProduct}){
    _commentRepository.checkComment(idUser: sl.get<SharedPreferenceHelper>().getIdUser,
     idProduct: idProduct, 
     onSuccess: (check) {
      print(check);
       update();
       return check;
     }, onError:
      (e) {
        print(e);
      },);
      return false;
  }
  
  ///
  /// go to evualate
  ///
  void gotoEvaluate(String idOrder,String idProduct ){
    Get.toNamed(DetailOrderRoutes.EVALUATE,arguments: [idOrder,idProduct]);
  }
  ///
  /// find order detail.
  ///
  void findOrderDetail() {
    _orderRepository.getOrder(
      idOrder: idOrder,
      onSuccess: (onSuccess) async {
        isLoading = false;
        orderResponse = onSuccess.first;
        await findDeliveryMan();
        await findStore(orderResponse.listProduct!.first.idUser!);
        update();
      },
      onError: (erorr) {
        print(erorr.toString());
      },
      statusOrder: '',
    );
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
    Get.toNamed(ProfileRoutes.GG_MAP_MARKER, arguments: [
      storeResponse.id!,
      //orderResponse.idEmployee!,
    ]);
  }

  ///
  /// Handle type order.
  ///
  void handleTypeOrder() {
    switch (orderResponse.statusOrder) {
      case PENDING:
        break;
      case DELIVERING:
        gotoGoogleMapMaker();
        break;
      case DONE:
        break;
      default:
    }
  }
}
