import 'package:flutter/material.dart';
import 'package:fooding_project/routes/app_routes.dart';
import 'package:fooding_project/routes/routes_path/home_routes.dart';
import 'package:fooding_project/routes/routes_path/login_routes.dart';
import 'package:fooding_project/screens/bottombar/bottombar_pages.dart';
import 'package:fooding_project/screens/home/home_screen.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginRoutes.LOGIN,
      getPages: AppPages.list,
     );
  }
}

