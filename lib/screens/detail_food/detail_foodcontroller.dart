import 'package:get/get.dart';

class DetailFoodController extends GetxController{
   bool isCheckFavorite = false;
 ///
 /// click favorite
 ///
   void clickFavorite(){
    isCheckFavorite = true;
    update();
   }
   @override
  void onInit() {
    
    super.onInit();
    clickFavorite();
  }
}