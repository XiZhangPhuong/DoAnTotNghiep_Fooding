// ignore_for_file: constant_identifier_names

import 'package:fooding_project/screens/location/add_location/add_location_page.dart';
import 'package:fooding_project/screens/location/location_page.dart';
import 'package:get/get.dart';

import '../../screens/location/add_location/add_location_binding.dart';
import '../../screens/location/location_binding.dart';

class LocationRoutes {
  static const String LOCATION = '/location';
  static const String ADDLOCATION = '/addlocation';

  static List<GetPage> list = [
    GetPage(
      name: LOCATION,
      page: () => const LocationPage(),
      binding: LocationBinding(),
    ),
     GetPage(
      name: ADDLOCATION,
      page: () => const AddLocationPage(),
      binding: AddLocationBinding(),
    ),
  ];
}
