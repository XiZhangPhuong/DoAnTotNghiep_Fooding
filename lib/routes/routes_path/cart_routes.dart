// ignore_for_file: constant_identifier_names

import 'package:fooding_project/screens/cart/cart_binding.dart';
import 'package:fooding_project/screens/cart/cart_pages.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CartRoutes {
  static const CART = '/cart';

  static List<GetPage> list = [
    GetPage(
      name: CART,
      page: () => const CartPage(),
      binding: CartBinding(),
    ),
  ];
}
