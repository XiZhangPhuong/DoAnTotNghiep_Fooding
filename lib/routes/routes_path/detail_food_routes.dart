
// ignore_for_file: constant_identifier_names

import 'package:fooding_project/screens/detail_food/detail_foodbinding.dart';
import 'package:fooding_project/screens/detail_food/detail_foodpage.dart';
import 'package:fooding_project/screens/store/store_binding.dart';
import 'package:fooding_project/screens/store/store_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class DetailtFoodRoutes {
  static const DETAILT_FOOD = '/detailt_food';
  static const STORE = '/store';

  static List<GetPage> list = [
    GetPage(
      name: STORE,
      page: () => const StorePage(),
      binding: StoreBinding(),
    ),

      GetPage(
      name: DETAILT_FOOD,
      page: () => const DetailFoodPage(),
      binding: DetailFoodBinding(),
    ),
   
  ];
}