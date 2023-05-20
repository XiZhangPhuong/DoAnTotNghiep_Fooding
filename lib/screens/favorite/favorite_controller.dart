import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/repository/products_repository.dart';
import 'package:fooding_project/routes/routes_path/favorite_routes.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final ProductsRepository _productsRepository = ProductsRepository();
  bool isLoadingFavorites = false;
  List<Products> listProductFavorite = [];
  String idUser = sl<SharedPreferenceHelper>().getIdUser;

  @override
  void onInit() {
    super.onInit();
    _getProductFavorite();
  }

    ///
  /// go to detailFood
  ///
  void gotoDetailFood(String id) {
    Get.toNamed(FavoriteRoutes.DETAIL_FOOD, arguments: id);
  }


   ///
  /// format sold
  ///
  String formatSold(int sales) {
    if (sales >= 1000) {
      double formattedSales = sales / 1000;
      return '${formattedSales.toStringAsFixed(1)}k đã bán';
    } else {
      return '$sales đã bán';
    }
  }

  ///
  /// get product favorite
  ///
  Future<void> _getProductFavorite() async {
    _productsRepository.getListProductFavorite(
      idUser: idUser,
      onSucess: (data) {
        listProductFavorite = data;
        print(listProductFavorite.length.toString());
        
        isLoadingFavorites = true;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Click delete fovorite product
  ///
  Future<void> clickDeleteProduct({required Products productRequest}) async {
    productRequest.favorites!.remove(idUser);
    _productsRepository.updateProduct(
      idProduct: productRequest.id!, 
       product: productRequest, 
       onSucess: () {
         _getProductFavorite();
         IZIAlert().success(message: 'Hủy yêu thích thành công');
         update();
       }, 
       onError: (error) {
         print(error);
       },);
  }
}
