// ignore_for_file: constant_identifier_names


import 'package:get/get.dart';

import '../../screens/auth/login/login_binding.dart';
import '../../screens/auth/login/login_pages.dart';

class AuthRoutes {
  static const LOGIN = '/login';
  static const SINGUP = '/singup';
  static List<GetPage> list = [
    GetPage(
      name: LOGIN,
      page: () => const LoginPages(),
      binding: LoginBinding(),
    ),

  ];
}
