import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/cart/cart_request.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/model/store/store.dart';
import 'package:fooding_project/screens/dashboard/dashboard_controller.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailFoodController extends GetxController {
  bool isCheckFavorite = false;
  bool isLoading = false;
  int currentIndex = 0;
  String idProduct = "";
  String idStore = "";
  String timeStore = "";
  Products? productsModel;
  Store? userModel;
  List<Products> listProducts = [];
  List<Products> listProductsCard = [];
  int quantity = 0;
  String idUser = sl.get<SharedPreferenceHelper>().getIdUser;

  ///
  /// click favorite
  ///
  void clickFavorite() {
    isCheckFavorite = !isCheckFavorite;
    update();
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
    getCartList();
  }

  ///
  /// add cart
  ///
  Future<void> addCart(Products products) async {
    if (checkIdProduct(products.id!)) {
      return;
    }
    EasyLoading.show(status: "Đang cập nhật");
    IZIAlert().success(message: 'Thêm món ăn thành công');
    listProductsCard.add(products);
      pushProductToFireStore(idUser,listProductsCard);
    EasyLoading.dismiss();
    update();
  }

  ///
  /// goto payment
  ///
  void gotoPayment() {
    Get.back(result: SUCCESS);
  }

  ///
  /// go to cart
  ///
  void gotoCard() {
    Get.back();
    final data = Get.find<DashBoardController>();
    data.curenIndex.value = 2;
    data.update();
  }

  ///
  /// push product to firestore
  ///
  Future<void> pushProductToFireStore(String userId,List<Products> listProduct)  async{
    final cart = CartRquest(
      idUser: userId,
      listProduct: listProduct
    );
   final  CollectionReference collection_Cart = FirebaseFirestore.instance.collection("carts");
   await collection_Cart.doc(cart.idUser!).set(cart.toMap());
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
      getProductList();
      print(idStore);
      isLoading = true;
      // ignore: avoid_print
      print(productsModel!.toMap());
      update();
    }
  }

  ///
  /// get data products
  ///
  Future<void> getProductList() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('products')
            .where('idUser', isEqualTo: idStore)
            .get();
    if (querySnapshot.docs.isNotEmpty) {
      for (var element in querySnapshot.docs) {
        Products products = Products.fromMap(element.data());
        listProducts.add(products);
      }
      update();
    }
  }

  ///
  /// get data cart
  ///
  Future<void> getCartList() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('carts')
            .where('idUser', isEqualTo: idUser)
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
      gettimeStore(user.openHour!, user.closeHour!);
      print(userModel!.toMap());
      update();
    }
  }

  ///
  /// check id product add cart
  ///
  bool checkIdProduct(String idProduct) {
    for (var i in listProductsCard) {
      if (i.id == idProduct) {
        return true;
      }
    }
    return false;
  }

  ///
  /// on off store
  ///
  void gettimeStore(String start, String end) {
    DateFormat format = DateFormat('HH:mm');
    DateTime time = format.parse(end);
    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(time);

    // Lấy thời gian hiện tại
    TimeOfDay now = TimeOfDay.now();

    // So sánh đối tượng TimeOfDay với thời gian hiện tại
    if (timeOfDay.hour < now.hour ||
        (timeOfDay.hour == now.hour && timeOfDay.minute < now.minute)) {
      timeStore = "Đang mở cửa : $start - $end";
    } else {
      timeStore = "Đã đóng cửa : $start - $end";
    }
  }
}
