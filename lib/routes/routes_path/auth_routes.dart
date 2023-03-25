// ignore_for_file: constant_identifier_names

import 'package:fooding_project/screens/introduction/introduction_binding.dart';
import 'package:fooding_project/screens/introduction/introduction_page.dart';
import 'package:fooding_project/screens/splash/splash_binding.dart';
import 'package:fooding_project/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../../screens/auth/login/login_binding.dart';
import '../../screens/auth/login/login_pages.dart';
import '../../screens/dashboard/dashboard_binding.dart';
import '../../screens/dashboard/dashboard_screen.dart';

class AuthRoutes {
  static const LOGIN = '/login';
  static const SINGUP = '/singup';
  static const DASHBOARD = '/dashboard';
  static const SPLASH = '/splash';
  static const INTRODUCTION = '/introduction';
  static List<GetPage> list = [
    GetPage(
      name: LOGIN,
      page: () => const LoginPages(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: DASHBOARD,
      page: () => const DashBoardScreen(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: INTRODUCTION,
      page: () => const IntroductionPage(),
      binding: IntroductionBinding(),
    ),
  ];
}
