import 'package:fooding_project/screens/dashboard/dashboard_binding.dart';
import 'package:fooding_project/screens/dashboard/dashboard_screen.dart';
import 'package:fooding_project/screens/evaluate/evaluate_binding.dart';
import 'package:fooding_project/screens/evaluate/evaluate_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class DetailOrderRoutes {
  static const String EVALUATE = "/evaluate";
    static const String DOASH__BOARD = "/doash_board";

  static List<GetPage> list = [
     
     GetPage(
      name: EVALUATE,
      page: () =>  const EvaluatePage(),
      binding: EvaluateBinding(),
    ),

    GetPage(
      name: DOASH__BOARD,
      page: () =>  const BottomBarPage(),
      binding: DashBoardBinding(),
    ),

  ];
}