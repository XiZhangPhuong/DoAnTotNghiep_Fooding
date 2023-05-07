import 'package:fooding_project/screens/evaluate/evaluate_controller.dart';
import 'package:get/get.dart';

class EvaluateBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => EvaluateController());
  }

}