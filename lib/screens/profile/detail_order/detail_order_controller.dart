import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/order_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/detail_food_routes.dart';
import 'package:fooding_project/routes/routes_path/profile_routes.dart';
import 'package:fooding_project/screens/profile/google_map_marker/google_map_marker_page.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

class DetailOrderController extends GetxController {
  String idOrder = Get.arguments as String;

  final _orderRepository = GetIt.I.get<OrderResponsitory>();
  final _userResponsitory = GetIt.I.get<UserRepository>();
  bool isLoading = true;
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
    _orderRepository.updateOrder(
      idOrder: idOrder,
      orderResponse: OrderResponse(statusOrder: "CANCEL"),
      onSuccess: () {
        IZIAlert().success(message: "Hủy đơn hàng thành công");
        Get.back(result: SUCCESS);
      },
      onError: (erorr) {},
    );
  }
}
