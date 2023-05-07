import 'package:fooding_project/screens/profile/status_order/status_order_binding.dart';
import 'package:fooding_project/screens/profile/status_order/status_order_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class DashBoardRoutes {
  static const STATUS = '/status';
  static List<GetPage> list = [
    GetPage(
      name: STATUS,
      page: () => const StatusOrderPage(),
      binding: StatusOrderBinding(),
    ),
    
  ];
}
