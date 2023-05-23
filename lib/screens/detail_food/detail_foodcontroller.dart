// ignore_for_file: avoid_print, iterable_contains_unrelated_type

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/base_widget/my_dialog_alert_done.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/cart/cart_request.dart';
import 'package:fooding_project/model/comment/comment_request.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/model/store/store.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/cart_repository.dart';
import 'package:fooding_project/repository/comment_repository.dart';
import 'package:fooding_project/repository/favorite_repository.dart';
import 'package:fooding_project/repository/products_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/detail_food_routes.dart';
import 'package:fooding_project/screens/dashboard/dashboard_controller.dart';
import 'package:fooding_project/screens/favorite/favorite_controller.dart';
import 'package:fooding_project/screens/home/home_controller.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class DetailFoodController extends GetxController {
  bool isCheckFavorite = false;
  bool isLoading = false;
  bool isLoadingStore = false;
  bool isLoadingProduct = false;
  bool isLoadingListComment = false;
  bool isLoadingUser = false;
  int currentIndex = 0;
  String idProduct = "";
  String idStore = "";
  String timeStore = "";
  Products? productsModel;
  Store? userModel;
  int limit = 10;
  int countProduct = 0;
  List<Products> listProducts = [];
  List<Products> listProductsCart = [];
  List<Products> listProductFavorite = [];
  List<String> listFavorite = [];
  List<CommentRequets> listComment = [];
  List<User> listUser = [];
  User userReponse = User();
  int quantity = 0;
  double lat1 = 0;
  double lat2 = 0;
  double long1 = 0;
  double long2 = 0;
  String distance = '';
  String idUser = sl.get<SharedPreferenceHelper>().getIdUser;
  final ProductsRepository _productsRepository =
      GetIt.I.get<ProductsRepository>();
  final CartRepository _cartRepository = GetIt.I.get<CartRepository>();
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();
  final CommentRepository _commentRepository = GetIt.I.get<CommentRepository>();
  final FavoriteRepository _favoriteRepository =
      GetIt.I.get<FavoriteRepository>();

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
  /// get list product cart by idUser
  ///
  void getListProductCartByIdUser() {
    _cartRepository.getListProduct(
      idUser: idUser,
      onSuccess: (data) {
        listProductsCart = data;
        for (final i in listProductsCart) {
          print(i.name!);
        }
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// checkIdStore
  ///
  bool checkIDStore(String idStore) {
    for (final i in listProductsCart) {
      if (idStore != i.idUser) {
        return true;
      }
    }
    return false;
  }

  ///
  /// get all comment by id product
  ///
  Future<void> getAllComment() async {
    _commentRepository.getAllComment(
      idProduct: idProduct,
      onSuccess: (data) async {
        listComment = data;
        for (final i in listComment) {
          userReponse = await findUserByID(i.idUser!);
          listUser.add(userReponse);
        }
        isLoadingListComment = true;
        update();
      },
      onError: (e) {
        print(e);
      },
    );
  }

  ///
  /// count product by idStore
  ///
  void countProductByIdStore() {
    _productsRepository.countProductByIdStore(
      idStore: idStore,
      onSucess: (data) {
        countProduct = data;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// change page slide show
  ///
  void changeSlideShow(int value) {
    currentIndex = value;
    update();
  }

  List<String> listImageSlider = [
    'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-2733-1655805928?w=600&amp;type=o&quot',
    'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-4898-1679481632?w=600&amp;type=o&quot',
    'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-4747-1676348590?w=600&amp;type=o&quot'
  ];

  @override
  void onInit() {
    super.onInit();
    idProduct = Get.arguments as String;
    findProductByID(idProduct);
    getListProductCartByIdUser();
    
  }

  ///
  /// find product by id
  ///
  Future<void> findProduct() async {
    await _productsRepository.find(
      idProduct: idProduct,
      onSucess: (data) {
        productsModel = data;
        isLoadingProduct = true;
        findStoreByID();
        paginateProductsByNameCateogry();
        countProductByIdStore();
        isLoading = true;
        update();
      },
      onError: (error) {},
    );
  }

  ///
  /// fint user by id
  ///
  Future<User> findUserByID(String idUser) async {
    return _userRepository.findbyId(idUser: idUser);
  }

  ///
  /// fint store by id
  ///
  Future<void> findStoreByID() async {
    _userRepository.findStoreByID(
      idStore: productsModel!.idUser!,
      onSucces: (store) {
        userModel = store;
        isLoadingStore = true;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
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
    if (checkIDStore(products.idUser!)) {
      Get.dialog(showDialog(idUser, products));
      return;
    }
    addCartToFireStore(products);
  }

  ///
  /// add cart
  ///
  void addCartToFireStore(Products products) {
    EasyLoading.show(status: "Đang cập nhật");
    final CartRquest cartRquest = CartRquest();
    cartRquest.idUser = idUser;

    List<Products> listProductsCart1 = [];
    bool isDuplicate = listProductsCart1.any((item) => item.id == products.id);

    if (!isDuplicate) {
      listProductsCart1.add(products);
      cartRquest.listProduct = listProductsCart1;
        Get.back();
      _cartRepository.addCart(
        idUser: idUser,
        data: cartRquest,
        onError: (error) {
          EasyLoading.dismiss();
          print(error);
        },
        onSuccess: () {
          IZIAlert().success(message: 'Thêm món ăn thành công');
          EasyLoading.dismiss();
          final bot = Get.find<BottomBarController>();
          bot.countCartByIDStore();
          bot.update();
          update();
        },
      );
    } else {
      print('Sản phẩm đã tồn tại trong giỏ hàng');
    }
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
        final CartRquest cartRquest = CartRquest();
        listProductsCart.clear();
        listProductsCart.add(products);
        cartRquest.listProduct = listProductsCart;
        _cartRepository.updateCart(
          cartRquest: cartRquest,
          onSucess: () {
            Get.back();
            update();
            IZIAlert().success(message: 'Thay thế cửa hàng thành công');
          },
          onError: (error) {},
        );
      },
      onTapCancle: () {
        Get.back();
      },
    );
  }

  ///
  /// goto payment
  ///
  void gotoPayment() {
    Get.back(result: SUCCESS);
  }

  ////
  /// go to store
  ///on
  void gotoStore({required String idStore}) {
    Get.toNamed(DetailtFoodRoutes.STORE, arguments: idStore);
  }

  ///
  /// go to detail food
  ///
  void gotoDetailFood(String id) {
    Get.toNamed(DetailtFoodRoutes.DETAILT_FOOD, arguments: id);
  }

  ///
  /// click item product
  ///
  void clickItemProduct(String idProducts) {
    idProduct = idProducts;
    findProductByID(idProduct);
    update();
  }

  ///
  /// get all data products by name category
  ///
  Future<void> paginateProductsByNameCateogry() async {
    listProducts.clear();
    _productsRepository.paginateProductsByIDCateogry(
      limit: limit,
      idCategory: productsModel!.idCategory!,
      onSucess: (listProduct) {
        listProducts = listProduct;
        listProducts.removeWhere((element) => element.id == idProduct);
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
  /// find product by id
  ///
  Future<void> findProductByID(String idProduct) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('products')
            .where('id', isEqualTo: idProduct)
            .get();

    if (querySnapshot.docs.isNotEmpty) {
      final Products products =
          Products.fromMap(querySnapshot.docs.first.data());
      productsModel = products;
      idStore = productsModel!.idUser!;
      findAddress();
      paginateProductsByNameCateogry();
      countProductByIdStore();
      await getAllComment();
      await getListFavorite();
      Future.delayed(const Duration(seconds: 1), () {
        isLoading = true;
        update();
      });

      print(productsModel!.toMap());
     
    }
  }

  ///
  /// find address by idStore
  ///
  Future<void> findAddress() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: idStore)
            .get();
    if (querySnapshot.docs.isNotEmpty) {
      final Store user = Store.fromMap(querySnapshot.docs.first.data());
      userModel = user;
       List<String> listLatLong = userModel!.latLong!.split(';');
        final home = Get.find<HomeController>();
        lat1 = home.lat1;
        long1 = home.lon1;
        lat2  = double.parse(listLatLong.first);
        long2 = double.parse(listLatLong.last);
        final km =  Geolocator.distanceBetween(lat1, long1, lat2, long2)/1000;
        distance  = '${km.toStringAsFixed(2)}km';
      // ignore: avoid_print1
      isLoadingStore = true;
      update();
    }
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
  /// add favorite
  ///
  Future<void> addFavoriteToFireStore({required Products product}) async {
    if (IZIValidate.nullOrEmpty(idUser)) {
      Get.find<BottomBarController>().showLoginDialog();
      return;
    }
    if (isCheckFavorite == true) {
      listFavorite.remove(idUser);
      isCheckFavorite = false;

      Get.find<FavoriteController>().getProductFavorite();
      Get.find<FavoriteController>().update();
      IZIAlert().success(message: 'Đã hủy yêu thích');
    } else {
      if (listFavorite.contains(idUser)) {
        return;
      }
      listFavorite.add(idUser);
      isCheckFavorite = true;
      IZIAlert().success(message: 'Yêu thích thành công');
    }
    product.id = product.id;
    product.favorites = listFavorite;
    _productsRepository.updateProduct(
      idProduct: idProduct,
      product: product,
      onSucess: () {
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// get list favorite product
  ///
  Future<void> getListFavorite() async {
    _productsRepository.getListFavorite(
      idProduct: idProduct,
      onSuccess: (data) {
        listFavorite = data;
        for (final i in listFavorite) {
          print(i.toString());
          if (listFavorite.contains(idUser)) {
            isCheckFavorite = true;
          } else {
            isCheckFavorite = false;
          }
        }
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// bool check user like favorite
  ///
  bool checkUserLikeProduct() {
    for (final i in listFavorite) {
      if (i == idUser) {
        return true;
      }
    }
    return false;
  }

  ///
  ///
  ///
}
