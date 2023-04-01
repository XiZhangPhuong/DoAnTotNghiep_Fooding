import 'package:firebase_database/firebase_database.dart';
import 'package:fooding_project/model/category.dart';
import 'package:fooding_project/model/food/food.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class HomeController extends GetxController{
  // list string imageslidershow
  List<String> listImageSlider = ['https://images.foody.vn/res/g103/1025384/prof/s640x400/file_restaurant_photo_trld_16180-41e8a93c-210410223323.jpg',
  'https://images.foody.vn/res/g99/981415/prof/s640x400/foody-upload-api-foody-mobile-chao-ech-191119105448.jpg',
  'https://images.foody.vn/res/g112/1110497/prof/s640x400/file_restaurant_photo_3xxm_16380-02563484-211128121644.jpeg'];

  @override
  void onInit() {
    super.onInit();
    _getDataCategory();
    _getDataFood();
  }

  List<Category> listCategory = [];
  List<Food> listFood = [];

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
  /// get all data food form firebase
  ///
  void _getDataFood(){
    databaseFood.onValue.listen((event) { 
       listFood.clear();
      final data = event.snapshot.value as Map<dynamic,dynamic>;
      data.forEach((key, value) { 
        Food food = Food(id_Food: value['id_Food'],name_Food: value['name_Food'],category_Food: value['category_Food'],
        image_Food: value['image_Food'],information_Food: value['information_Food'],quantity: value['quantity'],price_Food: value['price_Food']
        
        );
        listFood.add(food);
        update();
      });
    });
  }
}