import 'package:fooding_project/screens/SHIPPER/chart_shipper/chart_shipper_binding.dart';
import 'package:fooding_project/screens/SHIPPER/chart_shipper/chart_shipper_page.dart';
import 'package:fooding_project/screens/SHIPPER/profile_shipper/edit_profile_shipper/edit_profile_shipper_binding.dart';
import 'package:fooding_project/screens/SHIPPER/profile_shipper/edit_profile_shipper/edit_profile_shipper_page.dart';
import 'package:fooding_project/screens/SHIPPER/profile_shipper/profile_shipper_binding.dart';
import 'package:fooding_project/screens/SHIPPER/profile_shipper/profile_shipper_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class ProfileRoutes{
  static const PROFILE = '/profile';
  static const EDIT_PROFILE = '/edit_profile';
   static const CHART = '/chart';
  static List<GetPage> list = [
     GetPage(
      name: PROFILE,
      page: () => const ProfileShipperPage(),
      binding: ProfileShipperBinding(),
    ),
    GetPage(
      name: EDIT_PROFILE,
      page: () => const EditProfileShipper(),
      binding: EditProfileShipperBinding(),
    ),
     GetPage(
      name: CHART,
      page: () => const ChartShipperPage(),
      binding: ChartShipperBinding(),
    ),
  ];
}