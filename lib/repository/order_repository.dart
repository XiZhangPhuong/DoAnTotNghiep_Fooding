import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/cart/cart_request.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';

class OrderResponsitory {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

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
}
