import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:fooding_project/screens/chat/chat_controller.dart';
import 'package:get/get.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ChatController(),
        builder: (controller) {
          return Chat(
            messages: controller.messages,
            onSendPressed: (p0) => controller.handleSendPressed(p0),
            user: controller.user,
          );
        });
  }
}
