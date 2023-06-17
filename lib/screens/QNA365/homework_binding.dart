
import 'package:fooding_project/screens/QNA365/homework_controller.dart';
import 'package:get/get.dart';

class HomeWorkBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeWorkController());
  }

}