// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/cart/cart_request.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get/get.dart';

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
          final snap = await ref
              .where("idCustomer",
                  isEqualTo: sl<SharedPreferenceHelper>().getIdUser)
              .get();
          onSuccess(
              snap.docs.map((e) => OrderResponse.fromMap(e.data())).toList());
        } else {
          final snap = await ref
              .where("statusOrder", isEqualTo: statusOrder)
              .where("idCustomer",
                  isEqualTo: sl<SharedPreferenceHelper>().getIdUser)
              .get();
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
      bool flag = false;
      List<OrderResponse> list =
          ref.docs.map((e) => OrderResponse.fromMap(e.data())).toList();
      for (final item in list) {
        if (item.statusOrder! == "PENDING" ||
            item.statusOrder! == "DELIVERING") {
          flag = true;
          break;
        }
      }
      if (flag) {
        onSuccess(true);
      } else {
        onSuccess(false);
      }
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// update order.
  ///
  Future<void> updateOrder({
    required String idOrder,
    required OrderResponse orderResponse,
    required Function() onSuccess,
    required Function(dynamic erorr) onError,
  }) async {
    try {
      final ref = _fireStore
          .collection("orders")
          .doc(idOrder)
          .update(orderResponse.toMap());

      onSuccess();
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// get all product by status  = done
  ///
  Future<void> getAllOrderByStatus({
    required Function(List<Products> onSuccess) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final res = await FirebaseFirestore.instance
          .collection('orders')
          .where('statusOrder', isEqualTo: 'DONE')
          .where('idCustomer',
              isEqualTo: sl<SharedPreferenceHelper>().getIdUser)
          .get();

      final Set<String> uniqueProductIds = Set();
      final List<Products> productList = [];

      for (final doc in res.docs) {
        final List<dynamic> productsData = doc.data()['listProduct'];

        for (final productData in productsData) {
          final Products product = Products.fromMap(productData);
          if (!uniqueProductIds.contains(product.id)) {
            uniqueProductIds.add(product.id!);
            productList.add(product);
          }
        }
      }
      onSuccess(productList);
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// get list String idProduct by Collection Comment
  ///
  Future<void> getListIdProductByComment({
    required Function(List<String> listIDProduct) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('comments')
          .where('idUser',isEqualTo: sl<SharedPreferenceHelper>().getIdUser)
          .get();
      final List<String> idProductList = [];
      for (final doc in querySnapshot.docs) {
        final String idProduct = doc.data()['idProduct'];
        idProductList.add(idProduct);
      }

      onSuccess(idProductList);
    } catch (e) {
      onError(e);
    }
  }


  ///
  /// find order
  ///
  Future<void> findOrder({
  required String idOrder,
  required Function(OrderResponse orderResponse) onSuccess,
  required Function(dynamic error) onError,
}) async {
  try {
    final ref = FirebaseFirestore.instance.collection('orders').doc(idOrder);
    final docSnapshot = await ref.get();
    
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      if (data != null) {
        final orderResponse = OrderResponse.fromMap(data);
        onSuccess(orderResponse);
        return;
      }
    }  
    onError('Order not found');
  } catch (e) {
    onError(e);
  }
}

}
