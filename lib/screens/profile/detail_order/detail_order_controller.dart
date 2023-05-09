import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/order_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/detail_food_routes.dart';
import 'package:fooding_project/routes/routes_path/detail_order_routes.dart';
import 'package:fooding_project/screens/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class DetailOrderController extends GetxController {
  String idOrder = Get.arguments as String;

  final _orderRepository = GetIt.I.get<OrderResponsitory>();
  final _userResponsitory = GetIt.I.get<UserRepository>();
  bool isLoading = true;
  OrderResponse orderResponse = OrderResponse();
  User shipper = User();
  User storeResponse = User();
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
  /// go to evualate
  ///
  void gotoEvaluate(OrderResponse orderResponse){
    Get.toNamed(DetailOrderRoutes.EVALUATE,arguments: orderResponse);
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
      shipper =
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
}
