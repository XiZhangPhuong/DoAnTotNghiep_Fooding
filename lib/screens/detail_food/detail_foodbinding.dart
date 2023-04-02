import 'package:fooding_project/screens/detail_food/detail_foodcontroller.dart';
import 'package:get/get.dart';

class DetailFoodBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyReplace(() => DetailFoodController());
  }

}