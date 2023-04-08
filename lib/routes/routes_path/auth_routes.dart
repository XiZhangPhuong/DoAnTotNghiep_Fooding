// ignore_for_file: constant_identifier_names

import 'package:fooding_project/screens/auth/forgot_password/forgot_password_page.dart';
import 'package:fooding_project/screens/auth/login/login_page.dart';
import 'package:fooding_project/screens/auth/otp/otp_page.dart';
import 'package:fooding_project/screens/auth/reset_password/reset_password_page.dart';
import 'package:fooding_project/screens/auth/singup/singup_page.dart';
import 'package:fooding_project/screens/introduction/introduction_binding.dart';
import 'package:fooding_project/screens/introduction/introduction_page.dart';
import 'package:fooding_project/screens/splash/splash_binding.dart';
import 'package:fooding_project/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../../screens/auth/forgot_password/forgot_password_binding.dart';
import '../../screens/auth/login/login_binding.dart';
import '../../screens/auth/otp/otp_binding.dart';
import '../../screens/auth/reset_password/reset_password_binding.dart';
import '../../screens/auth/singup/singup_binding.dart';
import '../../screens/dashboard/dashboard_binding.dart';
import '../../screens/dashboard/dashboard_screen.dart';

class AuthRoutes {
  static const LOGIN = '/login';
  static const SINGUP = '/singup';
  static const DASHBOARD = '/dashboard';
  static const SPLASH = '/splash';
  static const INTRODUCTION = '/introduction';
  static const OTP = '/otp';
  static const FORGOT_PASSWORD = '/forgot_password';
  static const RESET = '/reset';
  static List<GetPage> list = [
    GetPage(
      name: LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: DASHBOARD,
      page: () => const  DashBoardScreen(),
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
    GetPage(
      name: SINGUP,
      page: () => const SingupPage(),
      binding: SingupBinding(),
    ),
    GetPage(
      name: OTP,
      page: () => const OTPPage(),
      binding: OTPBinding(),
    ),
    GetPage(
      name: FORGOT_PASSWORD,
      page: () => const ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: RESET,
      page: () => const ResetPasswordPage(),
      binding: ResetPasswordBinding(),
    ),
  ];
}
