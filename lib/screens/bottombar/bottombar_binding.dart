// ignore_for_file: prefer_const_constructors

import 'package:fooding_project/screens/bottombar/bottombar_pages.dart';
import 'package:get/get.dart';

class BottomBarBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BottomBarPage()); 
  }

}