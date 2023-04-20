import 'package:fooding_project/screens/cart/cart_binding.dart';
import 'package:fooding_project/screens/cart/cart_pages.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class DashBoardRoutes {
  static const CART = '/cart';

  static List<GetPage> list = [
    GetPage(
      name: CART,
      page: () => const CartPage(),
      binding: CartBinding(),
    ),
  ];
}
