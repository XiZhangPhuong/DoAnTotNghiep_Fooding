// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/repository/category_repository.dart';
import 'package:fooding_project/repository/products_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/search_routes.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:fooding_project/utils/color_resources.dart';
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
  RxInt selectedValue = 0.obs;
  RxInt selectedSoft = 0.obs;
  int selectedNameCategory = 0;
  List<String> listNameCategory = [];
  List<Products> listProducts = [];
  bool isLoadDingNameCategory = false;
  bool isLoadingProduct = false;
  int limit = 10;
  List<String> listNameStore = [];
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();
  final ProductsRepository _productsRepository =
      GetIt.I.get<ProductsRepository>();
  final CategoryRepository _categoryRepository =
      GetIt.I.get<CategoryRepository>();
  List<String> listSoft = ['Tất cả','Đang gần bạn','Bán chạy nhất'];
  // filter
  String filterNameStore = 'Tất cả';
  String filterNameCategory = Get.arguments as String;
  String filterSoft = 'Tất cả';


  @override
  void onInit() {
    super.onInit();

    getNameCategory();
    getAllNameStore();
    paginateProductsByNameCateogry();
  }

  ///
  ///
  ///
  Future<void> getNameCategory() async {
    _categoryRepository.getNameCategory(onError: (error) {
      print(error);
    }, onSuccess: (List<String> data) {
      data.insert(0, 'Tất cả danh mục');
      listNameCategory = data;
        for(int i  = 0;i<data.length;i++){
        if(data[i]  == filterNameCategory){
          selectedNameCategory = i;
          break;
        }
      }
      isLoadDingNameCategory = true;
      update();
    });
  }

 
 



  ///
  /// get all data products by name category
  ///
  Future<void> paginateProductsByNameCateogry() async {
    listProducts.clear();
    _productsRepository.paginateProductsByIDCateogry(
      limit: limit,
      idCategory: filterNameCategory,
      onSucess: (listProduct) {
        listProducts = listProduct;
        listProducts.sort((a, b) {
          return b.sold!.compareTo(a.sold!);
        },);
        if(filterNameCategory=='Tất cả danh mục'){
          paginateProduct();
        }
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
        listProducts.sort((a, b) {
          return b.sold!.compareTo(a.sold!);
        },);
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

  ///
  /// update select radio
  ///
  void updateSelectedValue(int value) {
    selectedValue.value = value;
    update();
  }

  ///
  /// update select NameCategory
  ///
 void updateSelectNameCategory(int value){
   selectedNameCategory =  value;
   update();
 }

   ///
  /// update select soft
  ///
  void updateSelectedSoft(int value) {
    selectedSoft.value = value;
    update();
  }


  ///
  /// onClick name Category
  ///
  void clickNameCategory() {
    Get.bottomSheet(
      Container(
        height: IZIDimensions.iziSize.height / 2,
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(IZIDimensions.SPACE_SIZE_3X),
            topRight: Radius.circular(IZIDimensions.SPACE_SIZE_3X),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: IZIDimensions.SPACE_SIZE_3X,
            vertical: IZIDimensions.SPACE_SIZE_3X,
          ),
          child: Column(
            children: [
              Text(
                'Chọn danh mục',
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w600,
                  fontSize: IZIDimensions.FONT_SIZE_H4,
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_3X,
              ),
              Wrap(
                  spacing: IZIDimensions.SPACE_SIZE_4X,
                  runSpacing: IZIDimensions.SPACE_SIZE_2X,
                  children: List.generate(
                    listNameCategory.length,
                    (index) => GestureDetector(
                      onTap: () {
                        updateSelectNameCategory(index);
                        filterNameCategory = listNameCategory[index];
                        paginateProductsByNameCateogry();                     
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: IZIDimensions.SPACE_SIZE_1X,
                          horizontal: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        decoration: BoxDecoration(
                          color: selectedNameCategory==index ? ColorResources.colorMain : 
                          ColorResources.WHITE,
                          border: selectedNameCategory==index ? null  : Border.all(
                            width: 0.8,color: ColorResources.colorMain,
                          ),
                          borderRadius: BorderRadius.circular(
                              IZIDimensions.BORDER_RADIUS_2X),
                        ),
                        child: Text(
                          listNameCategory[index],
                          style: TextStyle(
                            color: 
                            selectedNameCategory==index ? 
                            Colors.white : ColorResources.colorMain,
                            fontWeight: FontWeight.w600,
                            fontSize: IZIDimensions.FONT_SIZE_DEFAULT,
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// on click all store
  ///
  Future<void> clickAllStoreShowBottomSheet() async {
    Get.bottomSheet(
      Container(
        height: IZIDimensions.iziSize.height / 1.5,
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(IZIDimensions.SPACE_SIZE_3X),
            topRight: Radius.circular(IZIDimensions.SPACE_SIZE_3X),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: IZIDimensions.SPACE_SIZE_3X,
            vertical: IZIDimensions.SPACE_SIZE_3X,
          ),
          child: Column(
            children: [
              Text(
                'Chọn cửa hàng',
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w600,
                  fontSize: IZIDimensions.FONT_SIZE_H4,
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_2X,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: listNameStore.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      updateSelectedValue(index);
                      filterNameStore = listNameStore[index];
                      Get.back();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listNameStore[index],
                          style: TextStyle(
                            color: ColorResources.BLACK,
                            fontWeight: FontWeight.w600,
                            fontFamily: NUNITO,
                            fontSize: index == 0
                                ? IZIDimensions.FONT_SIZE_H4
                                : IZIDimensions.FONT_SIZE_H6,
                          ),
                        ),
                        Obx(
                          () => Radio(
                            value: index,
                            activeColor: ColorResources.colorMain,
                            groupValue: selectedValue.value,
                            onChanged: (value) {
                              updateSelectedValue(value as int);
                              filterNameStore = listNameStore[index];
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


   ///
  /// on click all store
  ///
  Future<void> clickSoftt() async {
    Get.bottomSheet(
      Container(
        height: IZIDimensions.iziSize.height / 1.5,
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(IZIDimensions.SPACE_SIZE_3X),
            topRight: Radius.circular(IZIDimensions.SPACE_SIZE_3X),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: IZIDimensions.SPACE_SIZE_3X,
            vertical: IZIDimensions.SPACE_SIZE_3X,
          ),
          child: Column(
            children: [
              Text(
                'Chọn phương thức lọc',
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontFamily: NUNITO,
                  fontWeight: FontWeight.w600,
                  fontSize: IZIDimensions.FONT_SIZE_H4,
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_2X,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: listSoft.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      updateSelectedSoft(index);
                      filterSoft = listSoft[index];
                      paginateProductsByNameCateogry();
                      Get.back();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listSoft[index],
                          style: TextStyle(
                            color: ColorResources.BLACK,
                            fontWeight: FontWeight.w600,
                            fontFamily: NUNITO,
                            fontSize: index == 0
                                ? IZIDimensions.FONT_SIZE_H4
                                : IZIDimensions.FONT_SIZE_H6,
                          ),
                        ),
                        Obx(
                          () => Radio(
                            value: index,
                            activeColor: ColorResources.colorMain,
                            groupValue: selectedSoft.value,
                            onChanged: (value) {
                              updateSelectedSoft(value as int);
                              filterSoft = listSoft[index];
                              paginateProductsByNameCateogry();
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// get all name store
  ///
  Future<void> getAllNameStore() async {
    _userRepository.getAllNameStore(
      onSuccess: (data) {
        listNameStore = data;
        listNameStore.insert(0, 'Tất cả');
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }
}
