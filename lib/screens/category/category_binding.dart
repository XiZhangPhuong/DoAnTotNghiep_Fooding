import 'package:fooding_project/screens/category/category_controller.dart';
import 'package:get/get.dart';

class CategoryBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryController());
  }

}