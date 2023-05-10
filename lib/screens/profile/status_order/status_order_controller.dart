import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/order_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/profile_routes.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StatusOrderController extends GetxController {
  int choiceItem = 0;
  List<dynamic> timeList1 = [
    "Chờ duyệt",
    "Đang giao",
    "Đã hủy",
    "Thành công",
  ];
  List<OrderResponse> listOrder = [];
  final _orderResponsitory = GetIt.I.get<OrderResponsitory>();
  final _userRespository = GetIt.I.get<UserRepository>();
  RefreshController refreshController = RefreshController();
  bool isLoading = true;
  User userResponse = User();
  bool isLoadingChangeTab = false;
  @override
  void onInit() {
    super.onInit();
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      choiceItem = Get.arguments as int;
      getAllOrder();
    }
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

  ///
  /// Choose Item.
  ///
  void onChoiceItem(int index) async {
    isLoadingChangeTab = true;
    update();
    choiceItem = index;

    await getAllOrder();
    isLoadingChangeTab = false;
    update();
  }

  ///
  /// Get all Order.
  ///
  Future<void> getAllOrder() async {
    listOrder.clear();
    refreshController.resetNoData();
    await _orderResponsitory.getOrder(
      statusOrder: formatStatusOrderFilter(),
      idOrder: '',
      onSuccess: (onSuccess) async {
        if (onSuccess.isNotEmpty) {
          listOrder = onSuccess;
          await findStore(listOrder.first.listProduct!.first.idUser!);
        }
        isLoading = false;
        update();
        refreshController.refreshCompleted();
      },
      onError: (erorr) {
        isLoading = false;
        update();
        print(erorr.toString());
      },
    );
  }

  ///
  /// Go to detail order.
  ///
  void gotoDetailOrder(int index) {
    Get.toNamed(
      ProfileRoutes.DETAIL_ORDER,
      arguments: listOrder[index].id,
    );
  }

  ///
  /// format status order
  ///
  String formatStatusOrderFilter() {
    switch (choiceItem) {
      case 0:
        return PENDING;
      case 1:
        return DELIVERING;
      case 2:
        return CANCEL;
      case 3:
        return DONE;
      default:
        return PENDING;
    }
  }

  String formatStatuString(String item) {
    switch (item) {
      case PENDING:
        return "Chờ nhận đơn";
      case DELIVERING:
        return "Đang giao";
      case CANCEL:
        return "Đã Hủy";
      case DONE:
        return "Hoàn thành";
      default:
        return "Chờ nhận đơn";
    }
  }

  ///
  /// Find Store.
  ///
  Future<void> findStore(String idStore) async {
    await _userRespository.findStoreByID(
      idStore: idStore,
      onSucces: (store) {
        userResponse = store;
      },
      onError: (error) {
        print(error.toString());
      },
    );
  }
}
