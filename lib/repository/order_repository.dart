// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/cart/cart_request.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/app_constants.dart';

import '../model/order/order.dart';

class OrderResponsitory {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

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
    required Function(OrderResponse onSuccess) onSuccess,
    required Function(dynamic erorr) onError,
  }) async {
    try {
      final ref = await _fireStore
          .collection("orders")
          .where('idEmployee',
              isEqualTo: sl<SharedPreferenceHelper>().getIdUser)
          .get();
      if (ref.docs.isNotEmpty) {
        onSuccess(OrderResponse.fromMap(ref.docs.first.data()));
      } else {
        onError("errorr");
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

  Future<void> getOrderListTen({
    required Function(List<OrderResponse> onSuccess) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final ref = _fireStore.collection("orders");
      QuerySnapshot snap =
          await ref.where('statusOrder', isEqualTo: PENDING).get();
      if (snap.docs.isNotEmpty) {
        final orders = snap.docs
            .map((doc) =>
                OrderResponse.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
        final docRef = ref.doc(snap.docs.first.id);
        final listener = docRef.snapshots().listen((snap) {
          if (snap.exists) {
            final updatedOrder =
                OrderResponse.fromMap(snap.data() as Map<String, dynamic>);
            final index =
                orders.indexWhere((order) => order.id == updatedOrder.id);
            if (index != -1) {
              orders[index] = updatedOrder;
              onSuccess(orders);
            }
          } else {
            onSuccess([]);
          }
        });
        onSuccess(orders);
      } else {
        onSuccess([]);
      }
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// update order
  ///
  Future<void> updateOrder({
    required OrderResponse updatedOrder,
    required Function() onSuccess,
    required Function(dynamic e) onError,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(updatedOrder.id)
          .update(updatedOrder.toMap());
      onSuccess();
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// get all order status = DONE
  ///
  Future<void> getAllOrder({
    required String idUser,
    required Function(List<OrderResponse> data) onSuccess,
    required Function(dynamic e) onError,
  }) async {
    try {
      final ref = await FirebaseFirestore.instance
          .collection('orders')
          .where('status', isEqualTo: DONE)
          .where('idEmployee',isEqualTo: idUser)
          .get();
        List<OrderResponse> list = ref.docs.map((e) => OrderResponse.fromMap(e.data())).toList();
        onSuccess(list);
    } catch (e) {
      onError(e);
    }
  }
}
