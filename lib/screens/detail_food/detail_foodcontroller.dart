// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/base_widget/my_dialog_alert_done.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/cart/cart_request.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/model/store/store.dart';
import 'package:fooding_project/repository/cart_repository.dart';
import 'package:fooding_project/repository/products_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/detail_food_routes.dart';
import 'package:fooding_project/screens/dashboard/dashboard_controller.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class DetailFoodController extends GetxController {
  bool isCheckFavorite = false;
  bool isLoading = false;
  bool isLoadingStore = false;
  bool isLoadingProduct = false;
  int currentIndex = 0;
  String idProduct = "";
  String idStore = "";
  String timeStore = "";
  Products? productsModel;
  Store? userModel;
  int limit = 10;
  int countProduct = 0;
  List<Products> listProducts = [];
  List<Products> listProductsCart =
      Get.find<BottomBarController>().listProductsCard;
  int quantity = 0;
  String idUser = sl.get<SharedPreferenceHelper>().getIdUser;
  final ProductsRepository _productsRepository =
      GetIt.I.get<ProductsRepository>();
  final CartRepository _cartRepository = GetIt.I.get<CartRepository>();
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();

  ///
  /// click favorite
  ///
  void clickFavorite() {
    isCheckFavorite = !isCheckFavorite;
    update();
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
    if (checkIdProduct(products.id!)) {
      IZIAlert().error(message: 'Đã có trong giỏ hàng');
      return;
    }
    if (checkIdStore(products.idUser!)) {
      Get.dialog(showDialog(idUser, products));
      return;
    }
    addCartToFireStore();
  }

  ///
  /// add cart
  ///
  void addCartToFireStore() {
    final CartRquest cartRquest = CartRquest();
    cartRquest.idUser = idUser;
    listProductsCart.add(productsModel!);
    cartRquest.listProduct = listProductsCart;
    _cartRepository.addCart(
      idUser: idUser,
      data: cartRquest,
      onSucces: () {
        EasyLoading.show(status: "Đang cập nhật");
        IZIAlert().success(message: 'Thêm món ăn thành công');
        Get.find<BottomBarController>().countCartByIDStore();
        //Get.find<BottomBarController>().update();
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
        pushProductToFireStore(idUser, listProductsCart);
        Get.find<BottomBarController>().update();
        update();
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
  /// push product to firestore
  ///
  Future<void> pushProductToFireStore(
      String userId, List<Products> listProduct) async {
    final cart = CartRquest(idUser: userId, listProduct: listProduct);
    final CollectionReference collectionCart =
        FirebaseFirestore.instance.collection("carts");
    final cartDoc = await collectionCart.doc(userId).get();
    if (cartDoc.exists) {
      await collectionCart.doc(cart.idUser!).update(cart.toMap());
    }
    await collectionCart.doc(cart.idUser!).set(cart.toMap());
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
      isLoading = true;
      print(productsModel!.toMap());
      update();
    }
  }

  ///
  /// get data products : các món của cửa hàng
  ///
  Future<void> getProductList() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('products')
            .where('idUser', isEqualTo: idStore)
            .get();
    listProducts.clear();
    if (querySnapshot.docs.isNotEmpty) {
      for (var element in querySnapshot.docs) {
        Products products = Products.fromMap(element.data());
        if (products.id == idProduct) {
          listProducts.insert(0, products);
        } else {
          listProducts.add(products);
        }
      }
      update();
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
      // ignore: avoid_print1
      isLoadingStore = true;
      print(userModel!.toMap());
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
  bool checkIdStore(String idStore) {
    for (int i = 0; i < listProductsCart.length; i++) {
      if (idStore != listProductsCart[i].idUser!) {
        return true;
      }
    }
    return false;
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
}
