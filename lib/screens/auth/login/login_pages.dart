// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fooding_project/screens/auth/login/login_controller.dart';
import 'package:get/get.dart';

class LoginPages extends GetView<LoginController> {
  const LoginPages({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Login Page'),
            centerTitle: true,
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                controller.goToDashBoard();
              },
              child: Text('Login'),
            ),
          ),
        );
      },
    );
  }
}
