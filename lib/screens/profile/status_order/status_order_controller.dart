import 'package:get/get.dart';

class StatusOrderController extends GetxController {
  int choiceItem = Get.arguments ?? 0;
  List<dynamic> timeList1 = [
    "Chờ duyệt",
    "Đang giao",
    "Đã hủy",
    "Đánh giá",
  ];

  ///
  /// Choose Item.
  ///
  void onChoiceItem(int index) {
    choiceItem = index;
    update();
  }
}
