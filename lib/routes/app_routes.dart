import 'package:fooding_project/routes/routes_path/home_routes.dart';
import 'package:fooding_project/routes/routes_path/login_routes.dart';
import 'package:get/get.dart';

class AppPages{
  static List<GetPage> list = [
    ...LoginRoutes.list,
    ...HomeRoutes.list
  ];
}