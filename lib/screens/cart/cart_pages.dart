import 'package:flutter/material.dart';
import 'package:fooding_project/screens/cart/cart_controller.dart';
import 'package:get/get.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CartController(),
      builder: (controller) {
        return GetBuilder(
          init: CartController(),
          builder: (controller) {
            return Scaffold(
              
            );
          },
        );
      },
    );
  }
}