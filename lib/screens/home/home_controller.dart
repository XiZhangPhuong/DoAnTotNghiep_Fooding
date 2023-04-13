import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fooding_project/model/banner/banner.dart';
import 'package:fooding_project/model/category/category.dart';
import 'package:fooding_project/model/food/food.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/repository/category_repository.dart';
import 'package:fooding_project/routes/routes_path/home_routes.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class HomeController extends GetxController{
  
  final CategoryRepository _categoryRepository = GetIt.I.get<CategoryRepository>();

  PageController pageController = PageController(initialPage: 0);
  List<Category> listCategory = [];
  List<Food> listFood = [];
  List<Products> listProducts = [];
  bool isLoadingCategory = true;
  // list string imageslidershow
  List<String> listImageSlider = ['https://tea-3.lozi.vn/v1/images/resized/banner-mobile-2733-1655805928?w=600&amp;type=o&quot',
  'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-4898-1679481632?w=600&amp;type=o&quot',
  'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-4747-1676348590?w=600&amp;type=o&quot'];

  List<Banners> listBanners = [];

  int index = 0;
  void onChanGeSlideShow(int value){
    index = value;
    if(value==listImageSlider.length-1){
       Timer(const Duration(seconds: 1), () {
          pageController.jumpToPage(0);
        });
    }
    update();
  }
  @override
  void onInit() {
    super.onInit();
    _getDataCategory();
  }
  
 ///
 /// get all data banners
 ///
  
  void _getDataBanners()  {
    databaseBanner.onValue.listen((event) { 
      listBanners.clear();
      final  data = event.snapshot.value as Map<dynamic,dynamic>;
      data.forEach((key, value) { 
        Banners banners = Banners(id: value['id'],image: value['image']);
        listBanners.add(banners);
      });
    });
  }

  ///
  /// get all data category from firebasee
  ///
  
  Future<void> _getDataCategory() async {
     databaseCategory.onValue.listen((event) {
       listCategory.clear();
       final data = event.snapshot.value as Map<dynamic,dynamic>;
       data.forEach((key, value) { 
         Category category = Category(id: value['id'],thumnail: value['thumnail'],name: value['name']);
         listCategory.add(category);
       });
       isLoadingCategory =false;
       update();
    });
  }

 
  ///
  /// gotoDetailFood
  ///
  void gotoDetailFood(String id){
      Get.toNamed(HomeRoutes.DETAIL_FOOD,arguments: id);
  }
  

  ///
  /// push data product
  ///
 
}