import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapMarkerController extends GetxController {
  // Create Google map Controller.
  final userResponsitory = GetIt.I.get<UserRepository>();
  GoogleMapController? ggMapcontroller;

  //
  // Create Marker Map
  Marker? markerShiper;
  Marker? markerStore;
  Marker? markerCustomer;
  User userStore = User();
  User userCustomer = User();
  User userShiper = User();
  List<String> listIdUser = [];
  bool isLoading = true;
  @override
  void onInit() {
    super.onInit();
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      listIdUser = Get.arguments as List<String>;
      print(listIdUser);
      initValue();
    }
  }

  @override
  void dispose() {
    if (!IZIValidate.nullOrEmpty(ggMapcontroller)) {
      ggMapcontroller!.dispose();
    }
    super.dispose();
  }

  ///
  /// on Onit.
  ///
  void initValue() {
    findAllUser();
  }

  ///
  /// Find User
  ///
  Future<void> findAllUser() async {
    userCustomer = await userResponsitory.findbyId(
        idUser: sl<SharedPreferenceHelper>().getIdUser);
    print(userCustomer.toJson());
    await userResponsitory.finLocation(
      idLocation: userCustomer.idLocation!,
      onSucces: (loctions) async {
        ///
        /// Store.
        userStore =
            await userResponsitory.findbyId(idUser: listIdUser[0].toString());
        markerStore = Marker(
          markerId: MarkerId(userStore.id!),
          position: const LatLng(16.074729, 108.220205),
          //icon: IZIValidate.nullOrEmpty(userStore.avatar)?
          infoWindow: InfoWindow(
            title: userStore.fullName,
            snippet: userStore.phone,
          ),
        );
        print(userStore.toJson());

        ///
        /// Customer.
        double lat = double.parse(loctions.latlong!.split(';')[0]);
        double lng = double.parse(loctions.latlong!.split(';')[1]);
        markerCustomer = Marker(
          markerId: MarkerId(userCustomer.id!),
          //icon: IZIValidate.nullOrEmpty(userStore.avatar)?
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: userCustomer.fullName,
            snippet: userCustomer.phone,
          ),
        );
        ///
        /// Shiper.
        // FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(userShiper.id)
        //     .snapshots()
        //     .listen((querySnapshot) {
        //   userShiper =
        //       User.fromMap(querySnapshot.data() as Map<String, dynamic>);
        //   markerShiper = Marker(
        //     markerId: MarkerId(
        //       userShiper.id!,
        //     ),
        //     position: LatLng(
        //       double.parse(userShiper.latLong!.split(';')[0]),
        //       double.parse(
        //         userShiper.latLong!.split(';')[1],
        //       ),
        //     ),
        //     infoWindow: InfoWindow(
        //       title: userCustomer.fullName,
        //       snippet: userCustomer.phone,
        //     ),
        //   );
        // });
        isLoading = false;
        update();
      },
      onError: (error) {
        print(error.toString());
      },
    );
  }
}
