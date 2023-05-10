// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/banner/banner.dart';
import 'package:fooding_project/model/category/category.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/model/store/store.dart';
import 'package:fooding_project/repository/category_repository.dart';
import 'package:fooding_project/repository/products_repository.dart';
import 'package:fooding_project/routes/routes_path/home_routes.dart';
import 'package:fooding_project/screens/dashboard/dashboard_controller.dart';
import 'package:fooding_project/utils/fcm_notification.dart';
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
  final ProductsRepository _productsRepository =
      GetIt.I.get<ProductsRepository>();
  List<Store> listStore = [];
  List<Products> listProducts = [];
  List<Products> listProductRecommend = [];
  bool isLoadingCategory = true;
  bool isLoadingProduct = true;
  bool isLoadingProductRecomment = true;
  int limit = 10;
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
    getCategoryList();
    paginateProductsRecommnend();
    final bot = Get.find<BottomBarController>();
    bot.countCartByIDStore();
    bot.listenData();
    bot.update();
    refreshController.resetNoData();
    refreshController.refreshCompleted();
  }

  ///
  /// On loading.
  ///
  void onLoading() {
    paginateFlashSaleProduct();
    getCategoryList();
    paginateProductsRecommnend();
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  ///
  /// get data user
  ///

  @override
  void onInit() {
    super.onInit();
     FcmNotification.requestPermission();
    paginateFlashSaleProduct();
    getCategoryList();
    paginateProductsRecommnend();
    _getCurrentLocation();
  }

  @override
  void onClose() {
    super.onClose();
  }

  ///
  ///
  ///
  String tietKiemPrice(int price, int priceDiscount) {
    String str = '';
    double money = (priceDiscount - price).toDouble();
    str = 'Giảm ${IZIPrice.currencyConverterVND(money)}đ';
    return str;
  }

  ///
  /// go to category
  ///
  void gotoCategoryPage(String name) {
    Get.toNamed(HomeRoutes.CATEGORY, arguments: name);
  }

  ///
  /// go to SearchPage
  ///
  void gotoSearchPage(String name) {
    Get.toNamed(HomeRoutes.SEARCH, arguments: name);
  }

  ///
  ///  get list category
  ///
  Future<void> getCategoryList() async {
    listCategory.clear();
    await _categoryRepository.all(
      onSucess: (data) {
        listCategory = data;
        isLoadingCategory = false;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// get data products
  ///
  Future<void> paginateProducts() async {
    listProducts.clear();
    _productsRepository.paginateProducts(
      limit: 10,
      onSucess: (listProduct) {
        listProducts = listProduct;
        listProducts.shuffle();
        isLoadingProduct = false;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// get data products recommend
  ///
  Future<void> paginateProductsRecommnend() async {
    listProductRecommend.clear();
    _productsRepository.paginateRecommendProducts(
      limit: 10,
      onSucess: (listProduct) {
        listProductRecommend = listProduct;
        isLoadingProductRecomment = false;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// get data products flash sale
  ///
  Future<void> paginateFlashSaleProduct() async {
    listProducts.clear();
    _productsRepository.paginateFlashsaleProducts(
      limit: 10,
      onSucess: (listProduct) {
        listProducts = listProduct;
        isLoadingProduct = false;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
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
      await setCurrentLocation();

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        currentLocation = await Geolocator.getLastKnownPosition();
        await setCurrentLocation();

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      currentLocation = await Geolocator.getLastKnownPosition();
      await setCurrentLocation();

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    await Geolocator.getCurrentPosition().then((value) {
      currentLocation = value;
    });
    await setCurrentLocation();
  }

  ///
  /// Set Current location.
  ///
  Future<void> setCurrentLocation() async {
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
    });
  }

  ///
  /// format  sold product
  ///
  String formatSold(int sales) {
    if (sales >= 1000) {
      double formattedSales = sales / 1000;
      return '${formattedSales.toStringAsFixed(1)}k đã bán';
    } else {
      return '$sales đã bán';
    }
  }
}
