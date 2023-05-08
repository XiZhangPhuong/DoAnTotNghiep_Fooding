// ignore_for_file: avoid_print

import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/repository/cart_repository.dart';
import 'package:fooding_project/repository/order_repository.dart';
import 'package:fooding_project/screens/SHIPPER/home_shipper/home_shipper_page.dart';
import 'package:fooding_project/screens/home/home_screen.dart';
import 'package:fooding_project/screens/profile/profile_page.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';


class BottomBarShipperController extends GetxController {
  final CartRepository _cartRepository = GetIt.I.get<CartRepository>();
  final _orderRepository = GetIt.I.get<OrderResponsitory>();

  String statusOrder = '';
  String idOrder = '';

  final List<Map<String, dynamic>> pages = [
    {
      'label': "Home",
      'icon': ImagesPath.icon_trangchu,
      'page': const HomeShipperPage(),
    },
    {
      'label': "Đơn hàng",
      'icon': ImagesPath.icon_yeuthich,
      'page': const HomeScreenPage(),
    },
    {
      'label': "Tài khoản",
      'icon': ImagesPath.icon_taikhoan,
      'page': const ProfilePage(),
    },
  ];

  DateTime? currentBackPressTime;
  RxInt currentIndex = 0.obs;
  double sizeIcon = 24.0;
  List<Products> listProductsCard = [];
  String idUser = sl<SharedPreferenceHelper>().getIdUser;
  bool isLoading = false;
  int countCart = 0;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      if (Get.arguments.runtimeType == int) {
        currentIndex.value = Get.arguments as int;
      }
    }
  }

  ///
  /// Change page
  ///
  void onChangedPage(int index) {
    currentIndex.value = index;
    update();
  }



  /// double back press
  Future<bool> onDoubleBack() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      IZIAlert().info(message: "Nhấn lần nữa để thoát ứng dụng.");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void onClose() {
    currentIndex.close();
    super.onClose();
  }

  
  
}
