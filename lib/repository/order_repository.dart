// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/cart/cart_request.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';

import '../model/order/order.dart';

class OrderResponsitory {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  ///
  /// get all cart.
  ///
  Future<void> getCart(
    Function(CartRquest onSucces) onSucces,
    Function(dynamic e) onError,
  ) async {
    try {
      final querysnapshot = await _fireStore
          .collection("carts")
          .where("idUser", isEqualTo: sl<SharedPreferenceHelper>().getIdUser)
          .get();
      CartRquest cart = CartRquest.fromMap(querysnapshot.docs[0].data());
      onSucces(cart);
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// Update increment cart.
  ///
  Future<void> updateCart({required CartRquest cartRquest}) async {
    try {
      await _fireStore
          .collection("carts")
          .doc(sl<SharedPreferenceHelper>().getIdUser)
          .set(cartRquest.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  ///
  ///Delete Cart.
  ///
  Future<void> deleteCart() async {
    try {
      await _fireStore
          .collection("carts")
          .doc(sl<SharedPreferenceHelper>().getIdUser)
          .delete();
    } catch (e) {
      IZIAlert().error(message: e.toString());
    }
  }

  ///
  /// Put Order.
  ///
  Future<void> addOrder({
    required OrderResponse orderRequest,
    required Function() onSucces,
    required Function(dynamic e) onError,
  }) async {
    try {
      await _fireStore
          .collection("orders")
          .doc(orderRequest.id)
          .set(orderRequest.toMap());
      onSucces();
    } catch (e) {
      onError(e);
    }
  }
}
