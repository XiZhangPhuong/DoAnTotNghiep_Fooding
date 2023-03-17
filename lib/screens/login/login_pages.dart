// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:fooding_project/screens/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
            leading: const Icon(Icons.menu),
          ),
          body: Center(
            child: Lottie.asset('assets/images/image_login.json'),
          ),
        );
        
      },
     );
  }
}