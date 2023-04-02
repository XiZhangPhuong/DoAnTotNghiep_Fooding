import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/model/user.dart' as model;
import 'package:uuid/uuid.dart';

class UserRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  ///
  /// Add user to database.
  ///
  Future<void> addUser(String phone, String password) async {
    try {
      model.User userRequest = model.User();
      userRequest.id = const Uuid().v1();
      userRequest.phone = phone;
      userRequest.passWord = password;
      userRequest.avatar = "";
      userRequest.fullName = "";
      userRequest.email = "";
      userRequest.isDeleted = false;
      userRequest.typeUser = "CUSTOMER";
      await _fireStore
          .collection("users")
          .doc(userRequest.id)
          .set(userRequest.toMap());
      IZIAlert().success(message: "Đăng kí thành công");
    } catch (e) {
      IZIAlert().error(message: "Vui lòng thử lại sau");
    }
  }

  ///
  /// Get user.
  ///
  Future<model.User?> getUserDetails(
    String phone,
    String password,
  ) async {
    QuerySnapshot querySnapshot = await _fireStore.collection("users").get();

    for (final element in querySnapshot.docs) {
      model.User user =
          model.User.fromMap(element.data() as Map<String, dynamic>);
      if (user.phone == phone && user.passWord == password) {
        return user;
      }
    }
    return null;
  }
  ///
  /// Check phone Number.
  ///
    Future<bool> checPhone(
    String phone,
  ) async {
    QuerySnapshot querySnapshot = await _fireStore.collection("users").get();

    for (final element in querySnapshot.docs) {
      model.User user =
          model.User.fromMap(element.data() as Map<String, dynamic>);
      if (user.phone == phone ) {
        return true;
      }
    }
    return false;
  }
}
