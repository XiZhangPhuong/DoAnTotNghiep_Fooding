// ignore_for_file: constant_identifier_names

import 'package:fooding_project/screens/chat/chat_binding.dart';
import 'package:fooding_project/screens/chat/chat_page.dart';
import 'package:fooding_project/screens/feel_rating/feel_rating_binding.dart';
import 'package:fooding_project/screens/feel_rating/feel_rating_page.dart';
import 'package:fooding_project/screens/profile/detail_order/detail_order_page.dart';
import 'package:fooding_project/screens/profile/edit_profile/edit_profile_binding.dart';
import 'package:fooding_project/screens/profile/edit_profile/edit_profile_page.dart';
import 'package:fooding_project/screens/profile/google_map_marker/google_map_marker_page.dart';
import 'package:fooding_project/screens/profile/help/help_binding.dart';
import 'package:fooding_project/screens/profile/help/help_page.dart';
import 'package:fooding_project/screens/profile/profile_page.dart';
import 'package:fooding_project/screens/profile/status_order/status_order_binding.dart';
import 'package:fooding_project/screens/profile/status_order/status_order_page.dart';
import 'package:get/get.dart';

import '../../screens/profile/detail_order/detail_order_binding.dart';
import '../../screens/profile/profile_binding.dart';

class ProfileRoutes {
  static const PROFILE = '/profile';
  static const EDITPROFILE = '/edit_profile';
  static const STATUSORDER = '/status_order';
  static const DETAIL_ORDER = '/detail_order';
  static const GG_MAP_MARKER = '/gg_map_marker';
  static const FEEL_RATING = '/feel_rating';
  static const HELP = '/HELP';
  static const CHAT = '/chat';
  static List<GetPage> list = [
    GetPage(
      name: PROFILE,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: EDITPROFILE,
      page: () => const EditProfilePage(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: STATUSORDER,
      page: () => const StatusOrderPage(),
      binding: StatusOrderBinding(),
    ),
    GetPage(
      name: DETAIL_ORDER,
      page: () => const DetailOrderPage(),
      binding: DetailOrderBinding(),
    ),
    GetPage(
      name: GG_MAP_MARKER,
      page: () => const GoogleMapMarkerPage(),
      binding: DetailOrderBinding(),
    ),
    GetPage(
      name: FEEL_RATING,
      page: () => const FeelRatingPage(),
      binding: FellRatingBinding(),
    ),
    GetPage(
      name: HELP,
      page: () => HelpPage(),
      binding: HelpBinding(),
    ),
    GetPage(
      name: CHAT,
      page: () => const ChatPage(),
      binding: ChatBinding(),
    ),
  ];
}
