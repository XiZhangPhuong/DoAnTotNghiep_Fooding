import 'package:get/get.dart';

class DetailFoodController extends GetxController{
   bool isCheckFavorite = false;
 ///
 /// click favorite
 ///
   void clickFavorite(){
    isCheckFavorite = !isCheckFavorite;
    update();
   }

   List<String> listImageSlider = ['https://tea-3.lozi.vn/v1/images/resized/banner-mobile-2733-1655805928?w=600&amp;type=o&quot',
  'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-4898-1679481632?w=600&amp;type=o&quot',
  'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-4747-1676348590?w=600&amp;type=o&quot'];
   @override
  void onInit() {
    
    super.onInit();
  }
}