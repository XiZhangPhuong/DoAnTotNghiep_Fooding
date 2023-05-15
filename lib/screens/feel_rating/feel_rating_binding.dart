import 'package:fooding_project/screens/feel_rating/feel_rating_cotroller.dart';
import 'package:get/get.dart';

class FellRatingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FeelRatingController());
  }

}