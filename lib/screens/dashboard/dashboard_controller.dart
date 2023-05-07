
// ignore_for_file: avoid_print

import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/repository/cart_repository.dart';
import 'package:fooding_project/routes/routes_path/dash_board_routes.dart';
import 'package:fooding_project/screens/home/home_screen.dart';
import 'package:fooding_project/screens/profile/profile_page.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../routes/routes_path/cart_routes.dart';


class BottomBarController extends GetxController {
  final CartRepository _cartRepository = GetIt.I.get<CartRepository>();
  final List<Map<String, dynamic>> pages = [
    {
      'label': "Home",
      'icon': ImagesPath.icon_trangchu,
      'page': const HomeScreenPage(),
    },
    {
      'label': "Yêu thích",
      'icon': ImagesPath.icon_yeuthich,
      'page': const HomeScreenPage(),
    }, 
    {
      'label': "Tài khoản",
      'icon': ImagesPath.icon_taikhoan,
      'page': const ProfilePage() ,
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
    countCartByIDStore();
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

 
  
 
 ///
 /// gotoCart
 ///
 void gotoCart(){
    Get.toNamed(CartRoutes.PAYMENT);
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

  ///
  /// count cart by idStore
  ///
  void countCartByIDStore(){
    _cartRepository.counCartByIDUser(idUser: idUser, onSucess: (data) {
       countCart = data;
       isLoading = true;
       update();
    }, onError: (error) {
       print(error.toString());
    },);
  }


  ///
  /// goto status order
  ///
  void goToStatusOrder(){
     Get.toNamed(DashBoardRoutes.STATUS);
  }
}
