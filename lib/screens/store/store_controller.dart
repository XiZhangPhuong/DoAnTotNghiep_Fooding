// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/base_widget/my_dialog_alert_done.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/cart/cart_request.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/model/store/store.dart';
import 'package:fooding_project/repository/cart_repository.dart';
import 'package:fooding_project/repository/products_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/store_routes.dart';
import 'package:fooding_project/screens/dashboard/dashboard_controller.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StoreController extends GetxController {
  bool isLoadDingStore = false;
  bool isLoadingProduct = false;
  bool isLoadingNameCategory = false;
  bool isLoadingCountCart = false;
  String idStore = Get.arguments as String;
  final CartRepository _cartRepository = GetIt.I.get<CartRepository>();
  Store storeResponse = Store();
  String idUser = sl<SharedPreferenceHelper>().getIdUser;
  List<Products> listProducts = [];
  List<dynamic> listNameCategory = [];
  int curenIndex = 0;
  int limit = 10;
  int countSold = 0;
  int countCart = 0;
  RefreshController refreshController = RefreshController();
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();
  final ProductsRepository _productsRepository =
      GetIt.I.get<ProductsRepository>();

  List<Products> listProductsCart = [];

  @override
  void onInit() {
    super.onInit();
    findStoreByID();
    getNameCategoy();
  }

  ///
  /// change tabbar
  ///
  void changeTabbar(int index) {
    curenIndex = index;
    print(listNameCategory[index]);
    paginateProductByNameCategory(name: listNameCategory[index]);
    update();
  }

  ///
  /// gotoCart
  ///
  void gotoCart() {
    Get.toNamed(StoreRoutes.PAYMENT);
  }

  ///
  /// find store by id
  ///
  Future<void> findStoreByID() async {
    _userRepository.findStoreByID(
      idStore: idStore,
      onSucces: (store) {
        storeResponse = store;
        countSoldIDStore();
        countCartByIDStore();
        isLoadDingStore = true;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// count sold by idStore
  ///
  Future<void> countSoldIDStore() async {
    _productsRepository.countSoldProductByIdStore(
      idStore: idStore,
      onSucess: (data) {
        countSold = data;
        print(data);
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// count cart by idStore
  ///
  void countCartByIDStore() {
    _cartRepository.counCartByIDUser(
      idUser: idUser,
      onSucess: (data) {
        countCart = data;
        print(data);
        isLoadingCountCart = true;
        update();
      },
      onError: (error) {
        print(error.toString());
      },
    );
  }

  ///
  /// go to evualate
  ///
  void gotoEvualate() {
    Get.toNamed(StoreRoutes.EVALUATE);
  }

  ///
  /// paginate product by name Category
  ///
  Future<void> paginateProductByNameCategory({required String name}) async {
    listProducts.clear();
    _productsRepository.paginateProductsByIDCateogryandIdStore(
      idUser: idStore,
      idCategory: name,
      limit: limit,
      onSucess: (listProduct) {
        listProducts = listProduct;

        isLoadingProduct = true;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// paginate prodduct by idstore
  ///
  void paginateProductByIDStore() {
    _productsRepository.paginateProductByIDStore(
      idStore: idStore,
      onSucess: (data) {},
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// check opening hours
  ///
  String checkOpeningHours(String opentime, String closetime) {
    final now = DateTime.now();
    final openingTime = TimeOfDay(
        hour: int.parse(opentime.split(':')[0]),
        minute: int.parse(opentime.split(':')[1]));
    final closingTime = TimeOfDay(
        hour: int.parse(closetime.split(':')[0]),
        minute: int.parse(closetime.split(':')[1]));
    final currentTime = TimeOfDay.fromDateTime(now);

    if (currentTime.hour > openingTime.hour &&
        currentTime.hour < closingTime.hour) {
      return 'Đang mở cửa $opentime - $closetime';
    } else if (currentTime.hour == openingTime.hour &&
        currentTime.minute >= openingTime.minute) {
      return 'Đang mở cửa $opentime - $closetime';
    } else if (currentTime.hour == closingTime.hour &&
        currentTime.minute < closingTime.minute) {
      return 'Đang mở cửa $opentime - $closetime';
    } else {
      return 'Đã đóng cửa $opentime - $closetime';
    }
  }

  ///
  /// format  sold product
  ///
  String formatSold(int sales) {
    if (sales >= 1000) {
      double formattedSales = sales / 1000;
      return '${formattedSales.toStringAsFixed(1)}k sp đã bán';
    } else {
      return '$sales sp đã bán';
    }
  }

  ///
  /// get name category in Store
  ///
  Future<void> getNameCategoy() async {
    _productsRepository.getNameCategoryByIDStore(
      idStore: idStore,
      onSucess: (data) {
        listNameCategory = data;
        paginateProductByNameCategory(name: listNameCategory[0]);
        isLoadingNameCategory = true;

        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// check id product add cart
  ///
  bool checkIdProduct(String idProduct) {
    for (var i in listProductsCart) {
      if (i.id == idProduct) {
        return true;
      }
    }
    return false;
  }

  ///
  /// check idStore add cart
  ///
  bool checkIdStore(String idStore) {
    for (int i = 0; i < listProductsCart.length; i++) {
      if (idStore != listProductsCart[i].idUser!) {
        return true;
      }
    }
    return false;
  }

  ///
  /// add cart
  ///
  Future<void> addCart(Products products) async {
    if (IZIValidate.nullOrEmpty(idUser)) {
      Get.find<BottomBarController>().showLoginDialog();
      return;
    }
    if (checkIdProduct(products.id!)) {
      IZIAlert().error(message: 'Đã có trong giỏ hàng');
      return;
    }
    // trung id
    if (checkIdStore(products.idUser!)) {
      Get.dialog(showDialog(idUser, products));
      return;
    }
    addCartToFireStore(products);
  }

  ///
  /// add cart
  ///
  void addCartToFireStore(Products products) {
    final CartRquest cartRquest = CartRquest();
    cartRquest.idUser = idUser;
    listProductsCart.add(products);
    cartRquest.listProduct = listProductsCart;
    _cartRepository.addCart(
      idUser: idUser,
      data: cartRquest,
      onSucces: () {
        EasyLoading.show(status: "Đang cập nhật");
        IZIAlert().success(message: 'Thêm món ăn thành công');
        countCartByIDStore();
        EasyLoading.dismiss();
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// showDialog if !idStore
  ///
  Widget showDialog(String id, Products products) {
    return DialogCustom(
      description: 'Món ăn không cùng cửa hàng.Bạn có muốn thay thế không ?',
      agree: 'Có',
      cancel1: 'Không',
      onTapConfirm: () {
        _productsRepository.deleteCartByUserId(id);
        IZIAlert().success(message: 'Thay thế cửa hàng thành công');
        Get.back();
        listProductsCart.clear();
        listProductsCart.add(products);
        addCartToFireStore(products);
        //  pushProductToFireStore(idUser, listProductsCart);
        Get.find<BottomBarController>().update();
        update();
      },
      onTapCancle: () {
        Get.back();
      },
    );
  }
}
