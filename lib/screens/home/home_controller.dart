import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/banner/banner.dart';
import 'package:fooding_project/model/category/category.dart';
import 'package:fooding_project/model/food/food.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/model/store/store.dart';
import 'package:fooding_project/repository/category_repository.dart';
import 'package:fooding_project/routes/routes_path/home_routes.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Position? currentLocation;

class HomeController extends GetxController {
  final CategoryRepository _categoryRepository =
      GetIt.I.get<CategoryRepository>();
  RefreshController refreshController = RefreshController();
  PageController pageController = PageController(initialPage: 0);
  List<Category> listCategory = [];
  List<Food> listFood = [];
  List<Store> listStore = [];
  List<Products> listProducts = [];
  bool isLoadingCategory = true;
  // list string imageslidershow
  List<String> listImageSlider = [
    'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-2733-1655805928?w=600&amp;type=o&quot',
    'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-4898-1679481632?w=600&amp;type=o&quot',
    'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-4747-1676348590?w=600&amp;type=o&quot'
  ];

  List<Banners> listBanners = [];
  String street = "Không xác định";
  int index = 0;
  void onChanGeSlideShow(int value) {
    index = value;
    if (value == listImageSlider.length - 1) {
      Timer(const Duration(seconds: 1), () {
        pageController.jumpToPage(0);
      });
    }
    update();
  }

  ///
  /// On Refreshing.
  ///
  void onRefreshing() {
    getProductList();
    getCategoryList();
    refreshController.resetNoData();
    refreshController.refreshCompleted();
  }

  ///
  /// On loading.
  ///
  void onLoading() {
    getProductList();
    getCategoryList();
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  ///
  /// get data user
  ///

  @override
  void onInit() {
    super.onInit();
    // _categoryRepository.pushDataProduct();
    getCategoryList();
    _getCurrentLocation();
    getProductList();
  }

  ///
  /// go to SearchPage
  ///
  void gotoSearchPage() {
    Get.toNamed(HomeRoutes.SEARCH);
  }

  ///
  ///  get list category
  ///

  Future<void> getCategoryList() async {
    List<Category> categoryList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categorys').get();

    for (var document in querySnapshot.docs) {
      Category category =
          Category.fromMap(document.data() as Map<String, dynamic>);
      categoryList.add(category);
    }
    listCategory = categoryList;
    isLoadingCategory = false;
    //
    update();
  }

  ///
  /// get data products
  ///
  Future<void> getProductList() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();
    listProducts.clear();
    for (var element in querySnapshot.docs) {
      Products products =
          Products.fromMap(element.data() as Map<String, dynamic>);
      listProducts.add(products);
    }
    print(listProducts.length.toString());
    update();
  }

  ///
  /// Get current
  ///
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    await Geolocator.getCurrentPosition().then((value) {
      currentLocation = value;
    });
    if (!IZIValidate.nullOrEmpty(currentLocation)) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLocation!.latitude,
        currentLocation!.longitude,
      );
      final data = placemarks.first;
      street =
          "${data.subThoroughfare}-${data.thoroughfare}-${data.subAdministrativeArea}";

      update();
    }
  }

  ///
  /// gotoDetailFood
  ///
  void gotoDetailFood(String id) {
    Get.toNamed(HomeRoutes.DETAIL_FOOD, arguments: id)?.then((value) {
      if (IZIValidate.nullOrEmpty(value)) {
        return;
      }
      // final controller  =   Get.find<DashBoardController>();
      // controller.curenIndex.value = 2;
      // controller.update();
    });
  }

  ///
  /// push data product
  ///

}
