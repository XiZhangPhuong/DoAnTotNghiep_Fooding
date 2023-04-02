import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:fooding_project/model/category.dart';
import 'package:fooding_project/model/food/food.dart';
import 'package:fooding_project/routes/routes_path/home_routes.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class HomeController extends GetxController{
  PageController pageController = PageController(initialPage: 0);
  List<Category> listCategory = [];
  List<Food> listFood = [];
  // list string imageslidershow
  List<String> listImageSlider = ['https://intphcm.com/data/upload/poster-quang-cao-web-do-an.jpg',
  'https://intphcm.com/data/upload/poster-quang-cao-web-do-an.jpg',
  'https://i.ytimg.com/vi/cY0rHIw52kU/maxresdefault.jpg'];
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
   getDataFood();
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
  void gotoDetailFood(){
      Get.toNamed(HomeRoutes.DETAIL_FOOD);
  }
  ///
  /// get all data food form firebase
  ///
  // void _getDataFood(){
  //   databaseFood.onValue.listen((event) { 
  //      listFood.clear();
  //     final data = event.snapshot.value as Map<dynamic,dynamic>;
  //     data.forEach((key, value) { 
  //       Food food = Food(id_Food: value['id_Food'],name_Food: value['name_Food'],category_Food: value['category_Food'],
  //       image_Food: value['image_Food'],information_Food: value['information_Food'],quantity: value['quantity'],price_Food: value['price_Food']
        
  //       );
  //       listFood.add(food);
  //       update();
  //     });
  //   });
  // }

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