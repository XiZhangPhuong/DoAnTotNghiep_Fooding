import 'package:diacritic/diacritic.dart';
import 'package:flutter/widgets.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/repository/products_repository.dart';
import 'package:fooding_project/routes/routes_path/search_routes.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';

class SearchNewController extends GetxController {
  final TextEditingController txtfilter = TextEditingController();
  final ProductsRepository _productsRepository =
      GetIt.I.get<ProductsRepository>();
  String search = '';
  List<String> listHistorySearch =
      sl<SharedPreferenceHelper>().getListHistorySearch();
  String filterSearch = '';
  List<Products> listProductSearch = [];
  bool isLoadingProductSearch = false;

  @override
  void onInit() {
    super.onInit();
  }

  ///
  /// onTextChanged
  ///
  void onTextChanged(String value) {
    search = value;
    update();
  }

  ///
  /// onTextSubmid
  ///
  void onSubmitted(String value) {
    if (!IZIValidate.nullOrEmpty(value) &&
        !listHistorySearch.contains(value) &&
        value.length >= 2) {
      listHistorySearch.add(value);
      sl<SharedPreferenceHelper>().setHistorySearch(listHistorySearch);
    }
    txtfilter.text = '';
    search = '';
    filterSearch = value;
    getProductBuApproxtmateName();
    update();
  }

  ///
  /// deleteItemSearch
  ///
  void deleteItemSearch(String value) {
    listHistorySearch.remove(value);
    sl<SharedPreferenceHelper>()
        .removeItemHistorySearch(listHistorySearch, value);
    sl<SharedPreferenceHelper>().setHistorySearch(listHistorySearch);
    update();
  }

  ///
  /// deleteAllSeach
  ///
  void deleteAllSeach() {
    listHistorySearch.clear();
    sl<SharedPreferenceHelper>().setHistorySearch(listHistorySearch);
    update();
  }

  ///
  /// delete search
  ///
  void deleteText() {
    search = '';
    txtfilter.text = '';
    update();
  }

  ///
  /// onClickItemHistory Search
  ///
  void onClickItemHistorySearch(String value) {
    filterSearch = value;
    getProductBuApproxtmateName();
    update();
  }

  ///
  /// get product by approximate name
  ///
  Future<void> getProductBuApproxtmateName() async {
    listProductSearch.clear();
    _productsRepository.getProductByApproximateName(
      nameProduct: filterSearch,
      onSucess: (data) {
        for (final item in data) {
          String normalizedItem = removeDiacritics(item.name!.toLowerCase());
          String normalizedFilter =
              removeDiacritics(filterSearch.toLowerCase());

          if (normalizedItem.contains(normalizedFilter)) {
            listProductSearch.add(item);
          }
        }
        isLoadingProductSearch = true;
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

  String removeVietnamese(String text) {
    // Các ký tự tiếng Việt và ký tự tương ứng không dấu
    const vietnameseCharacters =
        'àáảãạâầấẩẫậăằắẳẵặèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđ';
    const nonVietnameseCharacters =
        'aaaaaaaaaaaaaaaaaeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyd';

    for (var i = 0; i < vietnameseCharacters.length; i++) {
      text =
          text.replaceAll(vietnameseCharacters[i], nonVietnameseCharacters[i]);
    }

    return text;
  }
}
