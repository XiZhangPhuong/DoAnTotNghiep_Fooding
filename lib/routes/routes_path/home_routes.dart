// ignore_for_file: constant_identifier_names

import 'package:fooding_project/screens/detail_food/detail_foodbinding.dart';
import 'package:fooding_project/screens/detail_food/detail_foodpage.dart';
import 'package:fooding_project/screens/home/home_binding.dart';
import 'package:fooding_project/screens/home/home_screen.dart';
import 'package:get/get.dart';

class HomeRoutes {
  static const String HOME = "/home";
  static const String DETAIL_FOOD = "/detail_food";
  static List<GetPage> list = [
    // GetPage(
    //   name: HOME,
    //   page: () => const HomeScreenPage(),
    //   binding: HomeBinding(),
    // ),

    GetPage(
      name: DETAIL_FOOD,
      page: () =>  DetailFoodPage(),
      binding: DetailFoodBinding(),
    ),
  ];
}
