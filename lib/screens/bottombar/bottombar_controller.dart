// ignore_for_file: prefer_const_constructors

import 'package:fooding_project/screens/cart/cart_pages.dart';
import 'package:fooding_project/screens/home/home_screen.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController{
   RxInt curenIndex = 0.obs;
    List<Map<String,dynamic>> pages = [
    {
      'label' : "Trang chủ",
       'page' : HomeScreenPage(),
    },

      {
      'label' : "Yêu thích",
       'page' : HomeScreenPage(),
    },

      {
      'label' : "Giỏ hàng",
       'page' : CartPage(),
    },

      {
      'label' : "Tài khoản",
       'page' : HomeScreenPage(),
    },
   ];
   @override
  void onInit() {
    
    super.onInit();
  }
   void changePage(int index){
      curenIndex.value  = index;
      update();
   }

  

}