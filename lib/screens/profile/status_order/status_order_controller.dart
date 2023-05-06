import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get/get.dart';

class StatusOrderController extends GetxController {
  int choiceItem = Get.arguments ?? 0;
  List<dynamic> timeList1 = [
    "Chờ duyệt",
    "Đang giao",
    "Đã hủy",
    "Đánh giá",
  ];

  @override
  void onInit() {
    super.onInit();
    //listenData();
  }

  ///
  /// Choose Item.
  ///
  void onChoiceItem(int index) {
    choiceItem = index;
    update();
  }

  ///
  /// Listen data.
  ///
  void listenData() {
    final reference = FirebaseFirestore.instance
        .collection('orders')
        .where("idCustomer", isEqualTo: sl<SharedPreferenceHelper>().getIdUser);
    reference.snapshots().listen(
      (querySnapshot) {
        querySnapshot.docChanges.forEach((change) {
          // Do something with change
          final data = change.doc.data();
          if (!IZIValidate.nullOrEmpty(data)) {
            OrderResponse user = OrderResponse.fromMap(data!);
            print(user.id);
          }
        });
      },
      onDone: () {
        print("done");
      },
    );
  }
}
