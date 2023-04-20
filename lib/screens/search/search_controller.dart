import 'package:fooding_project/repository/category_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class SearchController extends GetxController{
   CategoryRepository categoryRepository = GetIt.I.get<CategoryRepository>();

   List<String> listHistory = ['Bún đậu','Mì ý','Cơm chiên dương châu','Trà sửa'];
   List<String> listNameCategory = [];
   bool isLoadDingNameCategory = false;
  @override
  void onInit() {
    
    super.onInit();
    getNameCategory();
  }

  ///
  ///  
  ///
  Future<void> getNameCategory() async {
     listNameCategory  =  await categoryRepository.getNameCategory();
     isLoadDingNameCategory = true;
     update();
  }
}