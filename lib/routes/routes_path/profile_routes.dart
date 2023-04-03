// ignore_for_file: constant_identifier_names

import 'package:fooding_project/screens/profile/profile_page.dart';
import 'package:get/get.dart';

import '../../screens/profile/profile_binding.dart';

class ProfileRoutes {
  static const PROFILE = '/profile';
  static List<GetPage> list = [
    GetPage(
      name: PROFILE,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
  ];
}
