import 'package:fooding_project/screens/detail_food/detail_foodbinding.dart';
import 'package:fooding_project/screens/detail_food/detail_foodpage.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class FavoriteRoutes {
  static const String DETAIL_FOOD = "/detail_food";
  static List<GetPage> list = [
   
    GetPage(
      name: DETAIL_FOOD,
      page: () =>  const DetailFoodPage(),
      binding: DetailFoodBinding(),
    ),

   
  ];
}
