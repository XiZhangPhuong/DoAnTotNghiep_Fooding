// ignore_for_file: constant_identifier_names

import 'package:fooding_project/model/category/category.dart';
import 'package:fooding_project/screens/category/category_binding.dart';
import 'package:fooding_project/screens/category/category_page.dart';
import 'package:fooding_project/screens/detail_food/detail_foodbinding.dart';
import 'package:fooding_project/screens/detail_food/detail_foodpage.dart';
import 'package:fooding_project/screens/search/search_binding.dart';
import 'package:fooding_project/screens/search/search_page.dart';
import 'package:get/get.dart';

class HomeRoutes {
  static const String DETAIL_FOOD = "/detail_food";
  static const String SEARCH = '/search';
  static const String CATEGORY = '/category';
  static List<GetPage> list = [
   
    GetPage(
      name: DETAIL_FOOD,
      page: () =>  const DetailFoodPage(),
      binding: DetailFoodBinding(),
    ),

    GetPage(
      name: SEARCH,
      page: () =>  const SearchPage(),
      binding: SearchBinding(),
    ),

     GetPage(
      name: CATEGORY,
      page: () =>  const CategoryPage(),
      binding: CategoryBinding(),
    ),

  ];
}
