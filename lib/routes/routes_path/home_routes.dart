import 'package:fooding_project/screens/home/home_binding.dart';
import 'package:fooding_project/screens/home/home_pages.dart';
import 'package:get/get.dart';

class HomeRoutes {
  static const String HOME = "/home";
  static List<GetPage> list  = [
    GetPage(name: HOME, page: () =>const  HomeScreenPage(),binding: HomeBinding()),
  ];
}