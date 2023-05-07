// ignore_for_file: avoid_print

import 'package:fooding_project/model/store/store.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';


class StoreController extends GetxController{
   bool isLoadDingStore = false;
   String idStore = Get.arguments as String;
   Store storeResponse = Store();
   final UserRepository _userRepository = GetIt.I.get<UserRepository>();

   @override
  void onInit() {
    
    super.onInit();
    findStoreByID();
  }

  ///
  /// find store by id
  ///
  Future<void> findStoreByID() async {
     _userRepository.findStoreByID(idStore: idStore, onSucces: (store) {
        storeResponse = store;
        isLoadDingStore = true;
        update();
     }, onError: (error) {
        print(error);
     },);
  }
}

