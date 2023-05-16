import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/model/cart/cart_request.dart';
import 'package:fooding_project/model/product/product_new.dart';
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
  // Future<void> addCart({
  //   required String idUser,
  //   required CartRquest data,
  //   required Function() onSucces,
  //   required Function(dynamic error) onError,
  // }) async {
  //   try {
  //     final docRef = FirebaseFirestore.instance.collection('carts').doc(idUser);
  //     final doc = await docRef.get();
  //     if (doc.exists) {
  //       await docRef.update(data.toMap());
  //     } else {
  //       await docRef.set(data.toMap());
  //     }
  //     onSucces(

  //     );
  //   } catch (e) {
  //     onError(e);
  //   }
  // }

  Future<void> addCart({
    required String idUser,
    required CartRquest data,
    required Function() onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('carts').doc(idUser);
      final doc = await docRef.get();

      if (doc.exists) {
        final existingData = doc.data() as Map<String, dynamic>;
        final List<dynamic> existingProducts = existingData['listProduct'];
        final List<dynamic> newProducts = data.toMap()['listProduct'];

        final mergedProducts = [...existingProducts, ...newProducts];

        final updatedData = {
          'listProduct': mergedProducts,
        };

        await docRef.update(updatedData);
      } else {
        await docRef.set(data.toMap());
      }

      onSuccess();
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// get list product by idUser Cart
  ///
  ///
  Future<void> getListProduct({
    required String idUser,
    required Function(List<Products> data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('carts')
          .where('idUser', isEqualTo: idUser)
          .get();

      final List<Products> productList = querySnapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // Truy cập trường "listProduct" trong tài liệu Firestore để lấy danh sách sản phẩm
        final List<dynamic> listProductData = data['listProduct'];
        // Tạo một đối tượng Products từ dữ liệu tương ứng trong tài liệu
        return Products.fromMap(listProductData as Map<String, dynamic>);
      }).toList();

      onSuccess(productList);
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// count cart by idUser 1
  ///
  Future<void> counCartByIDUser({
    required String idUser,
    required Function(int data) onSucess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final reference = FirebaseFirestore.instance
          .collection('carts')
          .where('idUser', isEqualTo: idUser);
      reference.snapshots().listen((querySnapshot) {
        var countList = 0;
        for (var docChange in querySnapshot.docChanges) {
          if (docChange.doc.exists) {
            final cartRequest = CartRquest.fromMap(
                docChange.doc.data() as Map<String, dynamic>);
            countList += cartRequest.listProduct?.length ?? 0;
          } else {
            countList = 0;
          }
        }
        onSucess(countList);
      });
    } catch (e) {
      onError(e);
    }
  }
}
