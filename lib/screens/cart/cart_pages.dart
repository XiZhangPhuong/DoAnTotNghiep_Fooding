import 'package:flutter/material.dart';
import 'package:fooding_project/screens/cart/cart_controller.dart';
import 'package:get/get.dart';

import '../../utils/config.dart';
import '../zalo_pay/zalo_pay.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CartController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cart Page'),
            centerTitle: true,
          ),
          body: Dashboard(
            title: AppConfig.appName,
            version: AppConfig.version,
          ),
        );
      },
    );
  }
}
