
import 'package:flutter/material.dart';
import 'package:fooding_project/screens/store/store_controller.dart';
import 'package:get/get.dart';

class StorePage extends GetView<StoreController> {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StoreController(),
      builder: (StoreController controller) {
        return Scaffold(
            
        );
      },
    );
  }
}