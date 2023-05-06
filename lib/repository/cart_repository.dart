import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/model/cart/cart_request.dart';
import 'package:fooding_project/model/product/products.dart';

class CartRepository {
  ///
  ///  delete item cart by id
  ///
  Future<void> deleteByID({
    required String idCard,
    required Function() onSucces,
    required Function(dynamic error) onError,
  }) async {}

  ///
  /// add or update cart
  ///
  Future<void> addCart({
    required String idUser,
    required CartRquest data,
    required Function() onSucces,
    required Function(dynamic error) onError,
  }) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('carts').doc(idUser);
      final doc = await docRef.get();
      if (doc.exists) {
        await docRef.update(data.toMap());
      } else {
        await docRef.set(data.toMap());
      }
      onSucces();
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// count cart by idUser
  ///
  Future<void> counCartByIDUser({
    required String idUser,
    required Function(int data) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('carts')
              .where('idUser', isEqualTo: idUser)
              .get();
    List<Products> listProductsCard = [];
    if (querySnapshot.docs.isNotEmpty) {
      for (var element in querySnapshot.docs) {
        CartRquest cartRquest = CartRquest.fromMap(element.data());
        listProductsCard = cartRquest.listProduct!;
      } 
    }
   onSucess(listProductsCard.length);
    } catch (e) {
      onError(e);
    }
  }
}
