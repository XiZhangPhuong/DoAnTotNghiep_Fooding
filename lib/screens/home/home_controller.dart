// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_price.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/banner/banner.dart';
import 'package:fooding_project/model/category/category.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/model/store/store.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fooding_project/repository/category_repository.dart';
import 'package:fooding_project/repository/products_repository.dart';
import 'package:fooding_project/routes/routes_path/home_routes.dart';
import 'package:fooding_project/screens/dashboard/dashboard_controller.dart';
import 'package:fooding_project/utils/fcm_notification.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Position? currentLocation;

class HomeController extends GetxController {
  final CategoryRepository _categoryRepository =
      GetIt.I.get<CategoryRepository>();
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();
  RefreshController refreshController = RefreshController();
  PageController pageController = PageController(initialPage: 0);
  List<Category> listCategory = [];
  final ProductsRepository _productsRepository =
      GetIt.I.get<ProductsRepository>();
  List<Store> listStore = [];
  List<Products> listProducts = [];
  List<Products> listProductRecommend = [];
  List<Products> listProductAll = [];
  bool isLoadingCategory = true;
  bool isLoadingProduct = true;
  bool isLoadingUser = false;
  bool isLoadingStore = false;
  bool isLoadingProductRecomment = true;
  bool isLoadingProductAll = false;
  int limit = 10;
  double km = 0;
  User userReponse = User();
  User storeResponse = User();
  String idUser = sl<SharedPreferenceHelper>().getIdUser;
  String idStore = '';
  double lat1 = 0;
  double lat2 = 0;
  double lon1 = 0;
  double lon2 = 0;
  List<double> listKm = [];
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
    getAllProduct();
    final bot = Get.find<BottomBarController>();
    bot.countCartByIDStore();
    bot.listenData();
    bot.update();
    refreshController.resetNoData();
    refreshController.refreshCompleted();
  }

  ///
  /// Find user.
  ///
  Future<void> findUser() async {
    userReponse = await _userRepository.findbyId(idUser: idUser);
    List<String> list = userReponse.latLong!.split(';');
    lat1 = double.parse(list[0]);
    lon1 = double.parse(list[1]);
    isLoadingUser = true;
    update();
  }

  ///
  /// find store
  ///
  Future<User> findStore(String idStore) async {
    return await _userRepository.findbyId(idUser: idStore);
  }

  ///
  /// On loading.
  ///
  void onLoading() {
    paginateFlashSaleProduct();
    getCategoryList();
    paginateProductsRecommnend();
    refreshController.refreshCompleted();
    getAllProduct();
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
    getAllProduct();
    _getCurrentLocation();

    ;
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
  /// get all Product
  ///
Future<void> getAllProduct() async {
  _productsRepository.getAllListProduct(
    onSucess: (listProduct) async {
      listProductAll = listProduct;

      for (final item in listProduct) {
        storeResponse = await findStore(item.idUser!);
        currentLocation ??= await Geolocator.getLastKnownPosition();
        lat1 = currentLocation!.latitude;
        lon1 = currentLocation!.longitude;
        List<String> list = storeResponse.latLong!.split(';');
        lat2 = double.parse(list[0]);
        lon2 = double.parse(list[1]);
        listKm.add(Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000);
        print(Geolocator.distanceBetween(lat1, lon1, lat2, lon2));
      }

      for (int i = 0; i < listProductAll.length; i++) {
        for (int j = i + 1; j < listProductAll.length; j++) {
          if (listKm[i] > listKm[j]) {
            var tempProduct = listProductAll[i];
            listProductAll[i] = listProductAll[j];
            listProductAll[j] = tempProduct;

            var tempKm = listKm[i];
            listKm[i] = listKm[j];
            listKm[j] = tempKm;
          }
        }
      }

      isLoadingProductAll = true;
      update();
    },
    onError: (error) {
      print(error);
    },
  );
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
      onSucess: (listProduct) async {
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

  ///
  ///  price count product
  ///
  String getPriceDiscount(int price, int priceDiscount) {
    String str = '';
    int temp = price - priceDiscount;
    str = 'Giảm ${temp.toDouble()}đ';
    return str;
  }

  ///
  ///
  ///
  // String calculateDistance(String idStore) {
  //     findStore(idStore);
  //     lat1 = currentLocation!.latitude;
  //   lon1 = currentLocation!.longitude;
  //   var p = 0.017453292519943295;
  //   var c = cos;
  //   var a = 0.5 -
  //       c((lat2 - lat1) * p) / 2 +
  //       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  //   km =  (12742 * asin(sqrt(a)));
  //   return km.toStringAsFixed(1);
  // }
}
