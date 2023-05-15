import 'package:fooding_project/screens/review_food/review_food_controller.dart';
import 'package:get/get.dart';

class ReviewFoodBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ReviewFoodController());
  }

}