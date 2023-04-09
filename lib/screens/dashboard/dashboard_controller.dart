import 'package:fooding_project/screens/cart/cart_pages.dart';
import 'package:fooding_project/screens/home/home_screen.dart';
import 'package:fooding_project/screens/profile/profile_page.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  RxInt curenIndex = 0.obs;
  List<Map<String, dynamic>> pages = [
    {
      'label': "Trang chủ",
      'page': const HomeScreenPage(),
    },
    {
      'label': "Yêu thích",
      'page': const CartPage(),
    },
    {
      'label': "Giỏ hàng",
      'page': const CartPage(),
    },
    {
      'label': "Tài khoản",
      'page': const ProfilePage(),
    },
  ];
  void changePage(int index) {
    curenIndex.value = index;
    update();
  }
}
