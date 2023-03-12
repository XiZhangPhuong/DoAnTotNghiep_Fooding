// ignore_for_file: constant_identifier_names

import 'package:get/get_navigation/get_navigation.dart';

import '../../screens/dashboard/dashboard_binding.dart';
import '../../screens/dashboard/dashboard_screen.dart';

class DashBoardRoutes {
  static const DASHBOARD = '/dashboard';
  static List<GetPage> list = [
        GetPage(
      name: DASHBOARD,
      page: () => const DashBoardScreen(),
      binding: DashBoardBinding(),
    ),
  ];
}
