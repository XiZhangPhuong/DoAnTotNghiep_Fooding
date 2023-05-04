// ignore_for_file: constant_identifier_names
import 'package:fooding_project/screens/payment/payment_binding.dart';
import 'package:fooding_project/screens/payment/payment_page.dart';
import 'package:fooding_project/screens/voucher/voucher_page.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../screens/voucher/voucher_binding.dart';

class CartRoutes {
  static const PAYMENT = '/payment';
  static const VOUCHER = '/voucher';
  static List<GetPage> list = [
    GetPage(
      name: PAYMENT,
      page: () => const PaymentPage(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: VOUCHER,
      page: () => const VoucherPage(),
      binding: VoucherBinding(),
    ),
  ];
}
