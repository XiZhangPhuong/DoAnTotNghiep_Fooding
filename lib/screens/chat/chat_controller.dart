import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/order/order.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

import '../../di_container.dart';
import '../../sharedpref/shared_preference_helper.dart';

class ChatController extends GetxController {
  List<types.Message> messages = [];
  final user = types.User(
    id: sl<SharedPreferenceHelper>().getIdUser,
  );
  OrderResponse order = OrderResponse();
  bool isFirst = true;

  @override
  void onInit() {
    super.onInit();

    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      order = Get.arguments as OrderResponse;
      print(order.id);
    }

    loadMessages();
  }

  Future<void> handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    await _addMessage(textMessage);
  }

  Future<void> _addMessage(types.Message message) async {
    if (!isFirst) {
      messages.insert(0, message);
    }
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(order.id)
        .collection("message")
        .add(message.toJson());
    update();
  }

  void loadMessages() async {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(order.id)
        .collection("message")
        .snapshots()
        .listen((event) {
      if (event.docChanges.isNotEmpty) {
        if (isFirst) {
          for (final item in event.docChanges) {
            messages.insert(
                0,
                types.Message.fromJson(
                    item.doc.data() as Map<String, dynamic>));
          }
          messages.sort(
            (a, b) => (a.createdAt! > b.createdAt! ? -1 : 1),
          );
          isFirst = false;
          update();
        } else {
          for (final item in event.docChanges) {
            final types.Message mess =
                types.Message.fromJson(item.doc.data() as Map<String, dynamic>);
            if (mess.author.id != sl<SharedPreferenceHelper>().getIdUser) {
              messages.insert(0, mess);
            }
            update();
          }
        }
      }
    });
  }
}
