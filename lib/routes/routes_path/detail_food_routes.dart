
import 'package:fooding_project/screens/store/store_binding.dart';
import 'package:fooding_project/screens/store/store_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class DetailtFoodRoutes {
  // ignore: constant_identifier_names
  static const STORE = '/store';
  static List<GetPage> list = [
    GetPage(
      name: STORE,
      page: () => const StorePage(),
      binding: StoreBinding(),
    ),
   
  ];
}