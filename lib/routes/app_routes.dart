import 'package:fooding_project/routes/routes_path/auth_routes.dart';
import 'package:fooding_project/routes/routes_path/profile_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static List<GetPage> list = [
    ...AuthRoutes.list,
    ...ProfileRoutes.list,
  ];
}
