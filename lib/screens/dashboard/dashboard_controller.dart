// ignore_for_file: avoid_print

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/repository/cart_repository.dart';
import 'package:fooding_project/repository/order_repository.dart';
import 'package:fooding_project/routes/routes_path/dash_board_routes.dart';
import 'package:fooding_project/screens/home/home_screen.dart';
import 'package:fooding_project/screens/no_login/no_login_page.dart';
import 'package:fooding_project/screens/profile/profile_page.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/images_path.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../routes/routes_path/cart_routes.dart';

class BottomBarController extends GetxController {
  final CartRepository _cartRepository = GetIt.I.get<CartRepository>();
  final _orderRepository = GetIt.I.get<OrderResponsitory>();

  String statusOrder = '';
  String idOrder = '';
  RxBool isFooter = false.obs;

  final List<Map<String, dynamic>> pages = [
    {
      'label': "Home",
      'icon': ImagesPath.icon_trangchu,
      'page': const HomeScreenPage(),
    },
    {
      'label': "Yêu thích",
      'icon': ImagesPath.icon_yeuthich,
      'page': IZIValidate.nullOrEmpty(sl<SharedPreferenceHelper>().getIdUser)
          ? const NoLoginPage()
          : const HomeScreenPage(),
    },
    {
      'label': "Tài khoản",
      'icon': ImagesPath.icon_taikhoan,
      'page': IZIValidate.nullOrEmpty(sl<SharedPreferenceHelper>().getIdUser)
          ? const NoLoginPage()
          : const ProfilePage(),
    },
  ];

  DateTime? currentBackPressTime;
  RxInt currentIndex = 0.obs;
  double sizeIcon = 24.0;
  List<Products> listProductsCard = [];
  String idUser = sl<SharedPreferenceHelper>().getIdUser;
  bool isLoading = false;
  int countCart = 0;

  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      listFireStoreChange;
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
  void gotoCart() {
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

  @override
  void dispose() {
    super.dispose();
    listFireStoreChange.cancel();
  }

  ///
  /// count cart by idStore
  ///
  void countCartByIDStore() {
    _cartRepository.counCartByIDUser(
      idUser: idUser,
      onSucess: (data) {
        countCart = data;
        isLoading = true;
        listenData();
      },
      onError: (error) {
        print(error.toString());
      },
    );
  }

  ///
  /// goto status order
  ///
  void goToStatusOrder() {
    print(statusOrder);
    Get.toNamed(
      DashBoardRoutes.STATUS,
      arguments: statusOrder == "Đang đợi tài xế" ? 0 : 1,
    );
  }

  ///
  /// Listen Data.
  ///
  void listenData() async {
    if (IZIValidate.nullOrEmpty(sl<SharedPreferenceHelper>().getIdUser)) {
      return;
    }
    listFireStoreChange = FirebaseFirestore.instance
        .collection('orders')
        .where("idCustomer", isEqualTo: sl<SharedPreferenceHelper>().getIdUser)
        .snapshots()
        .listen((querySnapshot) {
      for (var change in querySnapshot.docChanges) {
        if (change.doc.exists) {
          OrderResponse orderResponse =
              OrderResponse.fromMap(change.doc.data() as Map<String, dynamic>);
          if (orderResponse.statusOrder == PENDING ||
              orderResponse.statusOrder == DELIVERING) {
            print(orderResponse.toJson());
            if (orderResponse.statusOrder! == PENDING) {
              statusOrder = "Đang đợi tài xế";
            } else if (orderResponse.statusOrder == DELIVERING) {
              statusOrder = "Tài xế đang giao";
            }
            print(statusOrder);
            idOrder = orderResponse.id!.split('-')[0];
            isFooter = true.obs;
            update();
            break;
          } else {
            statusOrder = '';
            isFooter = false.obs;
            update();
          }
        } else {
          print("quyen test 123");
          isFooter = false.obs;
          statusOrder = '';
          update();
        }
      }
    });
  }
}
