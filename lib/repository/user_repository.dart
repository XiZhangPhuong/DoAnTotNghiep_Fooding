import 'dart:io';
import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/location/location_response.dart';
import 'package:fooding_project/model/store/store.dart';
import 'package:fooding_project/model/user.dart' as model;
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';

class UserRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  ///
  /// Get user.
  ///
  Future<model.User?> getUserDetails(
    String phone,
  ) async {
    final querySnapshot = await _fireStore
        .collection("users")
        .where("phone", isEqualTo: phone)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      model.User user = model.User.fromMap(querySnapshot.docs[0].data());
      return user;
    } else {
      return null;
    }
  }

  ///
  /// Check phone Number.
  ///
  Future<bool> checPhone(
    String phone,
  ) async {
    final querySnapshot = await _fireStore
        .collection("users")
        .where("phone", isEqualTo: phone)
        .where("typeUser", isEqualTo: "SHIPPER")
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return true;
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
  /// Find user.
  ///
  Future<model.User> findbyId({required String idUser}) async {
    final querySnapshot = await _fireStore
        .collection("users")
        .doc(idUser)
        .get();
    return model.User.fromMap(querySnapshot.data() as Map<String, dynamic>);
  }
  ///
  /// Update User.
  ///
  Future<void> updateUser(model.User userResquest, String id) async {
    _fireStore.collection("users").doc(id).update(userResquest.toMap());
  }

  ///
  /// Up load Image.
  ///
  Future<String> unloadToStorage(File image) async {
    Reference ref = _storage
        .ref()
        .child('profilePics')
        .child(sl<SharedPreferenceHelper>().getIdUser);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  ///
  /// Add Location.
  ///
  Future<void> addLocation({
    required LocationResponse request,
    required Function onSucces,
    required Function(dynamic error) onError,
  }) async {
    try {
      await _fireStore
          .collection("users")
          .doc(sl<SharedPreferenceHelper>().getIdUser)
          .collection("locations")
          .doc(request.id)
          .set(request.toMap(), SetOptions(merge: true));
      onSucces();
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// Add Location.
  ///
  Future<void> updateLocation({
    required LocationResponse request,
    required String id,
    required Function onSucces,
    required Function(dynamic error) onError,
  }) async {
    try {
      await _fireStore
          .collection("users")
          .doc(sl<SharedPreferenceHelper>().getIdUser)
          .collection("locations")
          .doc(id)
          .update(request.toMap());
      onSucces();
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// Get all location.
  ///
  Future<void> getAllLocation({
    required Function(List<LocationResponse> loctions) onSucces,
    required Function(dynamic error) onError,
  }) async {
    try {
      final query = await _fireStore
          .collection("users")
          .doc(sl<SharedPreferenceHelper>().getIdUser)
          .collection("locations")
          .get();
      onSucces(
          query.docs.map((e) => LocationResponse.fromMap(e.data())).toList());
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// Find Location.
  ///
  Future<void> finLocation({
    required String idLocation,
    required Function(LocationResponse loctions) onSucces,
    required Function(dynamic error) onError,
  }) async {
    try {
      final query = await _fireStore
          .collection("users")
          .doc(sl<SharedPreferenceHelper>().getIdUser)
          .collection("locations")
          .doc(idLocation)
          .get();
      onSucces(LocationResponse.fromMap(query.data()!));
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// Check phone Location.
  ///
  Future<void> checkPhoneLocation({
    required String phone,
    required Function(bool isPhone) onSucces,
    required Function(dynamic error) onError,
  }) async {
    try {
      final query = await _fireStore
          .collection("users")
          .doc(sl<SharedPreferenceHelper>().getIdUser)
          .collection("locations")
          .where("phone", isEqualTo: phone)
          .get();
      onSucces(query.docs.isNotEmpty);
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// Delete Location.
  ///
  Future<void> deleteLocation({
    required String id,
    required Function onSucces,
    required Function onError,
  }) async {
    try {
      final query = await _fireStore
          .collection("users")
          .doc(sl<SharedPreferenceHelper>().getIdUser)
          .collection("locations")
          .doc(id)
          .delete();
      onSucces();
    } catch (e) {
      onError(e);
    }
  }

  ///
  /// find store by id
  ///
  Future<void> findStoreByID({
    required String idStore,
    required Function(Store store) onSucces,
    required Function(dynamic error) onError,
  }) async {
    try {
      final query = await _fireStore.collection("users").doc(idStore).get();
      onSucces(Store.fromMap(query.data() as Map<String, dynamic>));
    } catch (e) {
      onError(e);
    }
  }


   ///
  /// get all name store
  ///
  Future<void> getAllCustommer({
    required Function(List<User> data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try{
       final ref = await FirebaseFirestore.instance.collection('users')
       .where('typeUser',isEqualTo: 'CUSTOMER')
       .where('isDeleted',isEqualTo: false)
       .get();
    
    List<User> listData =  ref.docs.map((e) => User.fromMap(e.data())).toList();
    onSuccess(listData);
       
    }catch(e){
      onError(e);
    }
    
    
  }
}
