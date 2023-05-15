import 'package:fooding_project/screens/evaluate/evaluate_binding.dart';
import 'package:fooding_project/screens/evaluate/evaluate_page.dart';
import 'package:fooding_project/screens/payment/payment_binding.dart';
import 'package:fooding_project/screens/payment/payment_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class StoreRoutes {
  static const String  EVALUATE = '/evaluate';
  static const String  PAYMENT= '/payment';
  
  static List<GetPage> list = [
    GetPage(
      name: EVALUATE,
      page: () => const EvaluatePage(),
      binding: EvaluateBinding(),
    ),

     GetPage(
      name: PAYMENT,
      page: () => const PaymentPage(),
      binding: PaymentBinding(),
    ),
  ];
 
}
