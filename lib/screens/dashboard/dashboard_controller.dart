import 'package:fooding_project/screens/home/home_screen.dart';
import 'package:get/get.dart';

import '../cart/cart_pages.dart';

class DashBoardController extends GetxController{
  RxInt curenIndex = 0.obs;
    List<Map<String,dynamic>> pages = [
    {
      'label' : "Trang chủ",
       'page' : const HomeScreenPage(),
    },

      {
      'label' : "Yêu thích",
       'page' : const CartPage(),
    },

      {
      'label' : "Giỏ hàng",
       'page' : const CartPage(),
    },

      {
      'label' : "Tài khoản",
       'page' : const CartPage(),
    },
   ];
   void changePage(int index){
      curenIndex.value  = index;
      update();
   }
}