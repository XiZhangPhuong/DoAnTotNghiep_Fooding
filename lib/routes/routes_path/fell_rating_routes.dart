import 'package:fooding_project/screens/feel_rating/feel_rating_binding.dart';
import 'package:fooding_project/screens/feel_rating/feel_rating_page.dart';
import 'package:fooding_project/screens/review_food/review_fod_page.dart';
import 'package:fooding_project/screens/review_food/review_food_binding.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class FillRatingRoutes {
  static const EVALUTE = '/evaluate';
  static const REVIEW_FOOD = '/review_food';
  static List<GetPage> list = [
    GetPage(
      name: EVALUTE,
      page: () => const FeelRatingPage(),
      binding: FellRatingBinding(),
    ),

     GetPage(
      name: REVIEW_FOOD,
      page: () => const ReviewFoodPage(),
      binding: ReviewFoodBinding(),
    ),
    
  ];
}
