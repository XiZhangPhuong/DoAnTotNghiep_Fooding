import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/model/favorite/favorite.dart';

class FavoriteRepository{

  ///
  /// add favorite
  ///
  Future<void> addFavorite({
  required String idUser,
  required Favorite favorite,
  required Function() onSuccess,
  required Function(dynamic e) onError,
}) async {
  try {
    final favoritesCollection = FirebaseFirestore.instance.collection('favorites');

    // Kiểm tra nếu mục yêu thích đã tồn tại
    final querySnapshot = await favoritesCollection.doc(idUser).get();
    if (querySnapshot.exists) {
      await favoritesCollection.doc(idUser).update(favorite.toMap());
    } else {
      await favoritesCollection.doc(idUser).set(favorite.toMap());
    }

    // Gọi callback thành công
    if (onSuccess != null) {
      onSuccess();
    }
  } catch (e) {
    // Gọi callback lỗi
    if (onError != null) {
      onError(e);
    }
  }
}

Future<void> addFavorite1({
  required String idUser,
  required Favorite favorite,
  required Function() onSuccess,
  required Function(dynamic e) onError,
}) async {
  try {
    final favoritesCollection = FirebaseFirestore.instance.collection('favorites');

    // Thực hiện truy vấn để kiểm tra xem mục yêu thích đã tồn tại chưa
    final querySnapshot = await favoritesCollection
        .where('idUser', isEqualTo: idUser)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Mục yêu thích đã tồn tại, cập nhật danh sách mục yêu thích
      final favoriteDoc = querySnapshot.docs.first;
      final updatedFavorites = favoriteDoc.data()['listProduct'] as List<dynamic>;
      updatedFavorites.addAll(favorite.listProduct as Iterable);

      await favoriteDoc.reference.update({'listProduct': updatedFavorites});
    } else {
      // Mục yêu thích chưa tồn tại, tạo mới và lưu danh sách mục yêu thích
      await favoritesCollection.add(favorite.toMap());
    }

    // Gọi callback thành công
    if (onSuccess != null) {
      onSuccess();
    }
  } catch (e) {
    // Gọi callback lỗi
    if (onError != null) {
      onError(e);
    }
  }
}


}