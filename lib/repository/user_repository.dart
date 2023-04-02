import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/user.dart' as model;
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';

class UserRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  ///
  /// Add user to database.
  ///
  Future<void> addUser(String phone, String password, String id) async {
    try {
      model.User userRequest = model.User();
      userRequest.id = id;
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
      if (user.phone == phone) {
        return true;
      }
    }
    return false;
  }

  ///
  /// Find user.
  ///
  Future<model.User> findUser() async {
    final querySnapshot = await _fireStore
        .collection("users")
        .doc(sl<SharedPreferenceHelper>().getIdUser)
        .get();
    return model.User.fromMap(querySnapshot.data() as Map<String, dynamic>);
  }

  ///
  /// Update User.
  ///
  Future<void> updateUser(model.User userResquest, String id) async {
    _fireStore.collection("users").doc(id).update(userResquest.toMap());
  }
}
