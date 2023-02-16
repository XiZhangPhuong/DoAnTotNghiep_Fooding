import 'package:flutter/material.dart';
import 'package:fooding_project/screens/home/home_controller.dart';
import 'package:get/get.dart';


class HomeScreenPage extends GetView<HomeController> {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
   return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home Page123'),
            centerTitle: true,
            leading: const Icon(Icons.menu),
          ),
        );
      },
   );
  }
}