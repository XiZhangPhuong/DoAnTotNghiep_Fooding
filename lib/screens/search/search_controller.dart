import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/repository/category_repository.dart';
import 'package:fooding_project/repository/products_repository.dart';
import 'package:fooding_project/routes/routes_path/search_routes.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class SearchController extends GetxController {
  CategoryRepository categoryRepository = GetIt.I.get<CategoryRepository>();
  final ProductsRepository productsRepository =
      GetIt.I.get<ProductsRepository>();
  List<String> listHistory = [
    'Bún đậu',
    'Mì ý',
    'Cơm chiên dương châu',
    'Trà sửa'
  ];
  List<String> listNameCategory = [];
  List<Products> listProducts = [];
  bool isLoadDingNameCategory = false;
  bool isLoadingProduct = false;
  String nameCategory = Get.arguments as String;
  @override
  void onInit() {
    super.onInit();
    getNameCategory();
    getListProductFilter(nameCategory);
  }

  ///
  ///
  ///
  Future<void> getNameCategory() async {
    listNameCategory = await categoryRepository.getNameCategory();
    isLoadDingNameCategory = true;
    update();
  }

  ///
  ///  getListProduct Filter
  ///
  Future<void> getListProductFilter(String nameCategory) async {
    listProducts = await productsRepository.getProductList(nameCategory);
    isLoadingProduct = true;
    update();
  }

  ///
  /// go to detailFood
  ///
  void gotoDetailFood(String id) {
    Get.toNamed(SearchRoutes.DETAIL_FOOD, arguments: id);
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
}
