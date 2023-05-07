import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:fooding_project/routes/routes_path/cart_routes.dart';
import 'package:fooding_project/routes/routes_path/dash_board_routes.dart';
import 'package:fooding_project/routes/routes_path/detail_food_routes.dart';
import 'package:fooding_project/routes/routes_path/home_routes.dart';
import 'package:fooding_project/routes/routes_path/location_routes.dart';
import 'package:fooding_project/routes/routes_path/profile_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static List<GetPage> list = [
    ...HomeRoutes.list,
    ...AuthRoutes.list,
    ...CartRoutes.list,
    ...ProfileRoutes.list,
    ...LocationRoutes.list,
    ...DetailtFoodRoutes.list,
    ...DashBoardRoutes.list,
  ];
}
