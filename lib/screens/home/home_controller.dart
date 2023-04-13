import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fooding_project/model/category.dart';
import 'package:fooding_project/model/food/food.dart';
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
 
  // list string imageslidershow
  List<String> listImageSlider = ['https://tea-3.lozi.vn/v1/images/resized/banner-mobile-2733-1655805928?w=600&amp;type=o&quot',
  'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-4898-1679481632?w=600&amp;type=o&quot',
  'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-4747-1676348590?w=600&amp;type=o&quot'];
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
   // _getDataFood();
 //  getDataFood();
 _pushListCategory();
  }
  
  ///
  ///
  ///
void _pushListCategory(){
  _categoryRepository.pushListCategory();
}

  ///
  /// get all data category from firebasee
  ///
  void _getDataCategory(){
    databaseCategory.onValue.listen((event) {
       listCategory.clear();
       final data = event.snapshot.value as Map<dynamic,dynamic>;
       data.forEach((key, value) { 
         Category category = Category(id_category: value['id_category'],image_Category: value['image_Category'],name_Category: value['name_Category']);
         listCategory.add(category);
       });
       
       update();
    });
  }
  ///
  /// gotoDetailFood
  ///
  void gotoDetailFood(String id){
      Get.toNamed(HomeRoutes.DETAIL_FOOD,arguments: id);
  }

  Future<void> getDataFood() async {
    databaseFood.onValue.listen((event) {
       listFood.clear();
     // Lặp qua từng đối tượng và thêm vào danh sách
     final values = event.snapshot.value as Map<dynamic,dynamic>;
     values.forEach((key, value) {
      Food food = Food(id_Food: values['id_Food'],name_Food:  values['name_Food'],
      category_Food:  values['category_Food'],image_Food: values['image_Food'] ,
      information_Food: values['information_Food'],quantity: values['quantity'] ,price_Food: values['price_Food'] );
      listFood.add(food);
    
      });
      print(listFood.length.toString());
      update();
    });
  }
}