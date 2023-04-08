import 'package:fooding_project/routes/routes_path/cart_routes.dart';
import 'package:fooding_project/screens/cart/cart_pages.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
   List<String> listImageSlider = ['https://tea-3.lozi.vn/v1/images/resized/banner-mobile-2733-1655805928?w=600&amp;type=o&quot',
  'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-4898-1679481632?w=600&amp;type=o&quot',
  'https://tea-3.lozi.vn/v1/images/resized/banner-mobile-4747-1676348590?w=600&amp;type=o&quot'];

  int count = 0;

  ///
  /// tăng số lượng sản phẩm
  ///
  void increaseQuantity(){
    if(count<10){
      count++;
      update();
    }
  }
  ///
  /// giảm số lượng sản phẩm
  ///
  void reduceQuantity(){
    if(count>1){
      count--;
      update();
    }
  }

  ///
  /// goto trang thanh toán
  ///
  void gotoPaymentPage(){
    Get.toNamed(CartRoutes.PAYMENT);
  }
  @override
  void onInit() {
    super.onInit();
  }
}