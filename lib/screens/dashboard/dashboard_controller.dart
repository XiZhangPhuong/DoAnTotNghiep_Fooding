
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/cart/cart_request.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/screens/home/home_screen.dart';
import 'package:fooding_project/screens/profile/profile_page.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';

import '../../routes/routes_path/cart_routes.dart';


class BottomBarController extends GetxController {
  final List<Map<String, dynamic>> pages = [
    {
      'label': "Home",
      'icon': ImagesPath.icon_trangchu,
      'page': const HomeScreenPage(),
    },
    {
      'label': "Yêu thích",
      'icon': ImagesPath.icon_trangchu,
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
  String idUser = '';

  @override
  void onInit() {
    super.onInit();
    idUser = sl.get<SharedPreferenceHelper>().getIdUser;
    getCartList();
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
  /// get data cart
  ///
  Future<void> getCartList() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('carts')
            .where('idUser', isEqualTo:  idUser )
            .get();
    if (querySnapshot.docs.isNotEmpty) {
      for (var element in querySnapshot.docs) {
        CartRquest cartRquest = CartRquest.fromMap(element.data());
        listProductsCard = cartRquest.listProduct!;
      }
      update();
    }
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
}
