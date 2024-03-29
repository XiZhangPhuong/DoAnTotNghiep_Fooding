import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:fooding_project/utils/images_path.dart';
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
    // Get customer.
    userCustomer = await userResponsitory.findbyId(
        idUser: sl<SharedPreferenceHelper>().getIdUser);

    await userResponsitory.finLocation(
      idLocation: userCustomer.idLocation!,
      onSucces: (loctions) async {
        ///
        /// Store.
        userStore =
            await userResponsitory.findbyId(idUser: listIdUser[0].toString());
        markerStore = Marker(
          markerId: MarkerId(userStore.id!),
          position: !IZIValidate.nullOrEmpty(userStore.latLong)
              ? LatLng(
                  double.parse(userStore.latLong!.split(';')[0]),
                  double.parse(
                    userStore.latLong!.split(';')[1],
                  ))
              : const LatLng(16.074729, 108.220205),
          icon: await _getAssetIcon(Get.context!, ImagesPath.store_googlemap),
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
          icon: await _getAssetIcon(Get.context!, ImagesPath.user_googleMap),

          //icon: IZIValidate.nullOrEmpty(userStore.avatar)?
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: userCustomer.fullName,
            snippet: userCustomer.phone,
          ),
        );

        ///
        // Shiper.
        FirebaseFirestore.instance
            .collection('users')
            .doc(listIdUser[1])
            .snapshots()
            .listen((querySnapshot) async {
          User userShiper =
              User.fromMap(querySnapshot.data() as Map<String, dynamic>);
          markerShiper = Marker(
            markerId: MarkerId(
              userShiper.id!,
            ),
            position: LatLng(
              double.parse(userShiper.latLong!.split(';')[0]),
              double.parse(
                userShiper.latLong!.split(';')[1],
              ),
            ),
            icon: await _getAssetIcon(
                Get.context!, ImagesPath.delivery_gggolemap),
            infoWindow: InfoWindow(
              title: userShiper.fullName,
              snippet: userShiper.phone,
            ),
          );
          print(userShiper.toJson());
          update();
        });
        isLoading = false;
        update();
      },
      onError: (error) {
        print(error.toString());
      },
    );
  }

  Future<BitmapDescriptor> _getAssetIcon(
      BuildContext context, String icon) async {
    final Completer<BitmapDescriptor> bitmapIcon =
        Completer<BitmapDescriptor>();
    final ImageConfiguration config =
        createLocalImageConfiguration(context, size: Size(10, 10));

    AssetImage(icon)
        .resolve(config)
        .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
      final ByteData? bytes =
          await image.image.toByteData(format: ImageByteFormat.png);
      final BitmapDescriptor bitmap =
          BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
      bitmapIcon.complete(bitmap);
    }));

    return await bitmapIcon.future;
  }
}
