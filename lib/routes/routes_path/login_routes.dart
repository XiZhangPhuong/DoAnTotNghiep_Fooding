// ignore_for_file: constant_identifier_names

import 'package:fooding_project/screens/bottombar/bottombar_binding.dart';
import 'package:fooding_project/screens/bottombar/bottombar_pages.dart';
import 'package:fooding_project/screens/login/login_binding.dart';
import 'package:fooding_project/screens/login/login_pages.dart';
import 'package:get/get.dart';

class LoginRoutes{
  static const String LOGIN = "/login";
  static const String BOTTOMAPPBAR = "/bottomappbar";
  static List<GetPage> list = [
    GetPage(name: LOGIN, page: () => const LoginPages(),binding: LoginBinding()),
    GetPage(name: BOTTOMAPPBAR, page: () => const BottomBarPage(),binding: BottomBarBinding()),
    ];
}