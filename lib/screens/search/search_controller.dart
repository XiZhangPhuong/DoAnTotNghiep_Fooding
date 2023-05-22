// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/repository/category_repository.dart';
import 'package:fooding_project/repository/products_repository.dart';
import 'package:fooding_project/routes/routes_path/search_routes.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class SearchController extends GetxController {
  CategoryRepository categoryRepository = GetIt.I.get<CategoryRepository>();
  TextEditingController filter = TextEditingController();
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
  int limit = 10;
  String nameCategory = Get.arguments as String;
  final ProductsRepository _productsRepository =
      GetIt.I.get<ProductsRepository>();
  final CategoryRepository _categoryRepository =
      GetIt.I.get<CategoryRepository>();

  @override
  void onInit() {
    super.onInit();

    getNameCategory();
    if (IZIValidate.nullOrEmpty(nameCategory)) {
      paginateProduct();
    } else {
      paginateProductsByNameCateogry();
    }
  }

  ///
  ///
  ///
  Future<void> getNameCategory() async {
    _categoryRepository.getNameCategory(
        onError: (error) {
          print(error);
        },
        onSuccess: (List<String> data) {
          data.insert(0, 'Tất cả');
          listNameCategory = data;
          isLoadDingNameCategory = true;
          if (IZIValidate.nullOrEmpty(nameCategory)) {
            nameCategory = listNameCategory.first;
          } else {
            nameCategory = Get.arguments as String;
          }
          update();
        });
  }

  ///
  /// on change dropdowbutton
  ///
  void changeDropDow(String value) {
    nameCategory = value;
    print(nameCategory);
    if (value == 'Tất cả') {
      paginateProduct();
    } else {
      paginateProductsByNameCateogry();
    }
    update();
  }

  ///
  /// search textfield
  ///
  void search(String value) {
    if (IZIValidate.nullOrEmpty(value) &&
        IZIValidate.nullOrEmpty(nameCategory)) {
      paginateProduct();
    } else {
      paginateProductByNameProduct();
    }

    update();
  }

  ///
  ///
  ///
  Future<void> paginateProductByNameProduct() async {
    listProducts.clear();
    _productsRepository.paginateProductsByNameProduct(
      limit: limit,
      value: filter.text,
      onSucess: (listProduct) {
        listProducts = listProduct;
        listProducts.shuffle();
        isLoadingProduct = true;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// get all data products by name category
  ///
  Future<void> paginateProductsByNameCateogry() async {
    listProducts.clear();
    _productsRepository.paginateProductsByIDCateogry(
      limit: limit,
      idCategory: nameCategory,
      onSucess: (listProduct) {
        listProducts = listProduct;
        isLoadingProduct = true;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// get all data products by name category
  ///
  Future<void> paginateProduct() async {
    listProducts.clear();
    _productsRepository.paginateProducts(
      limit: limit,
      onSucess: (listProduct) {
        listProducts = listProduct;
        isLoadingProduct = true;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
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
