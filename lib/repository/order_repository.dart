// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_validate.dart';
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

  ///
  /// Get order.
  ///
  Future<void> getOrder({
    required String idOrder,
    required Function(List<OrderResponse> onSuccess) onSuccess,
    required Function(dynamic erorr) onError,
    required String statusOrder,
  }) async {
    try {
      final ref = _fireStore.collection("orders");
      if (IZIValidate.nullOrEmpty(idOrder)) {
        if (IZIValidate.nullOrEmpty(statusOrder)) {
          final snap = await ref.get();
          onSuccess(
              snap.docs.map((e) => OrderResponse.fromMap(e.data())).toList());
        } else {
          final snap =
              await ref.where("statusOrder", isEqualTo: statusOrder).get();
          print(snap.docs.toString());
          onSuccess(
              snap.docs.map((e) => OrderResponse.fromMap(e.data())).toList());
        }
      } else {
        final snap = await ref.doc(idOrder).get();
        onSuccess([OrderResponse.fromMap(snap.data() as Map<String, dynamic>)]);
      }
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// check order.
  ///
  Future<void> checkOrderExists({
    required Function(bool onSuccess) onSuccess,
    required Function(dynamic erorr) onError,
  }) async {
    try {
      final ref = await _fireStore
          .collection("orders")
          .where('idCustomer',
              isEqualTo: sl<SharedPreferenceHelper>().getIdUser)
          .get();
      if (ref.docs.isNotEmpty) {
        onSuccess(true);
      } else {
        onSuccess(false);
      }
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// get order check status
  ///
  Future<void> getOrderByidUser({
    required String idCustommer,
    required Function(OrderResponse onSuccess) onSuccess,
    required Function(dynamic erorr) onError,
    required String statusOrder,
  }) async {
    try {
      final ref = _fireStore
          .collection("orders")
          .where('idCustommer', isEqualTo: idCustommer)
          .get();
      OrderResponse? orderResponse;
      onSuccess(orderResponse!);
    } catch (e) {
      onError(e);
    }
  }
}
