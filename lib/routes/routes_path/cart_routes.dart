// ignore_for_file: constant_identifier_names
import 'package:fooding_project/screens/payment/payment_binding.dart';
import 'package:fooding_project/screens/payment/payment_page.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CartRoutes {
  static const PAYMENT = '/payment';

  static List<GetPage> list = [
    GetPage(
      name: PAYMENT,
      page: () => const PaymentPage(),
      binding: PaymentBinding(),
    ),
  ];
}
