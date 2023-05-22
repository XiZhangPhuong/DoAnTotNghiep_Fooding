import 'package:fooding_project/screens/search_new/search_new_controller.dart';
import 'package:get/instance_manager.dart';

class SearchNewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SearchNewController());
  }

}