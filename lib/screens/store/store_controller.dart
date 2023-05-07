// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/model/store/store.dart';
import 'package:fooding_project/repository/products_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/store_routes.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StoreController extends GetxController {
  bool isLoadDingStore = false;
  bool isLoadingProduct = false;
  bool isLoadingNameCategory = false;
  String idStore = Get.arguments as String;
  Store storeResponse = Store();
  List<Products> listProducts = [];
  List<dynamic> listNameCategory = [];
  int curenIndex = 0;
  int limit = 10;
  int countSold = 0;
  RefreshController refreshController = RefreshController();
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();
  final ProductsRepository _productsRepository =
      GetIt.I.get<ProductsRepository>();
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
  /// find store by id
  ///
  Future<void> findStoreByID() async {
    _userRepository.findStoreByID(
      idStore: idStore,
      onSucces: (store) {
        storeResponse = store;
        countSoldIDStore();
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
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// go to evualate
  ///
  void gotoEvualate(){
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
  ///
  ///
  void test() {
    for (int i = 0; i < listNameCategory.length; i++) {
      print(listNameCategory[i]);
    }
  }
}
