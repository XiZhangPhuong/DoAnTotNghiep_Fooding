import 'package:flutter/material.dart';
import 'package:fooding_project/repository/auth_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../routes/routes_path/auth_routes.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController phoneEditingController = TextEditingController();
  final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();

  ///
  /// Go to OTP.
  ///
  Future<void> gotoOTP() async {
    await _authRepository.phoneAuthentication(phoneEditingController.text);
    await Get.toNamed(
      AuthRoutes.OTP,
      arguments: [
        "forgot",
        phoneEditingController.text,
      ],
    );
  }
}
