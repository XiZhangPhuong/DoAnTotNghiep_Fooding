// ignore_for_file: avoid_print

import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/model/product/products.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/repository/comment_repository.dart';
import 'package:fooding_project/repository/order_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/detail_order_routes.dart';
import 'package:fooding_project/routes/routes_path/fell_rating_routes.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FeelRatingController extends GetxController {
  bool isLoadingOrder = false;
  List<OrderResponse> listOrder = [];
  List<Products> listProductCommet = [];
  List<String> listIdProduct = [];
  List<bool> isRatedList = [];
  bool isLoadingProduct = false;
  bool isLoadingId = false;
  int countProduct = 0;
  bool isLoading = true;
  User userResponse = User();
  RefreshController refreshController = RefreshController();
  final OrderResponsitory _orderResponsitory = GetIt.I.get<OrderResponsitory>();
  final _userRespository = GetIt.I.get<UserRepository>();
  final _commentRepository = GetIt.I.get<CommentRepository>();

  @override
  void onInit() {
    super.onInit();
    getAllOrder();
   
  }



  ///
  /// get idProduct by Comment
  ///
  void _getIdProductByComment(){
    _orderResponsitory.getListIdProductByComment(
      onSuccess: (listIDProduct) {
        listIdProduct = listIDProduct;
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// checkEvaluate
  ///
  void _checkEvaluate() {
  isRatedList = List.generate(listOrder.length, (index) => false);
  for (int i = 0; i < listOrder.length; i++) {
    List<Products>? products = listOrder[i].listProduct;
    if (products != null) {
      for (int j = 0; j < products.length; j++) {
        String productId = products[j].id!;
        if (listIdProduct.contains(productId)) {
          isRatedList[i] = true;
          break;
        }
      }
    }
  }
}


  ///
  /// go to evaluate
  ///
   


   ///
   /// click evaluate
   ///
   void clickEvalute(String idProduct,int index){
     if(isRatedList[index]==true){
      IZIAlert().error(message: 'Bạn đã đánh giá rồi');
      return;
     }
     Get.toNamed(FillRatingRoutes.EVALUTE,arguments: idProduct);
   }

   ///
   /// get all order
   ///

   Future<void> getAllOrder() async {
    listOrder.clear();
    refreshController.resetNoData();
    await _orderResponsitory.getOrder(
      statusOrder: 'DONE',
      idOrder: '',
      onSuccess: (onSuccess) async {
        if (onSuccess.isNotEmpty) {
          listOrder = onSuccess;
          print(listOrder.length.toString());
          await findStore(listOrder.first.listProduct!.first.idUser!);
          refreshController.refreshCompleted();
        }
        isLoading = false;
        update();
      },
      onError: (erorr) {
        isLoading = false;
        update();
        print(erorr.toString());
      },
    );
  }

  ///
  /// Find Store.
  ///
  Future<void> findStore(String idStore) async {
    await _userRespository.findStoreByID(
      idStore: idStore,
      onSucces: (store) {
        userResponse = store;
      },
      onError: (error) {
        print(error.toString());
      },
    );
  }

   ///
  /// go to evualate
  ///
  void gotoEvaluate(String idOrder,String idProduct ){
    Get.toNamed(DetailOrderRoutes.EVALUATE,arguments: [idOrder,idProduct]);
  }

  ///
  /// check Comment
  ///
  bool checkCommentProduct({required String idProduct}){
    bool hasComment = false;
    _commentRepository.checkComment(idUser: sl<SharedPreferenceHelper>().getIdUser,
     idProduct: idProduct, 
     onSuccess: (check) {
      print(check);
       update();
       hasComment = check;
     }, onError:
      (e) {
        print(e);
      },);
      return hasComment;
  }

 ///
 ///  tinh Tam Tinh
 ///
  double tinhTamTinh(List<Products> list){
    double sum = 0;
    for(final i in list){
      if(i.priceDiscount==0){
        sum+=i.price!;
      }else{
        sum+=i.priceDiscount!;
      }
    }
    return sum;
  }

  ///
  /// tinh Voucher
  ///
  double tinhVoucher(double tamtinh,double phiShip,double tongDon){
    double sum  = 0;
    sum = (tongDon - (tamtinh+phiShip));
    return sum;
  }

  ///
  /// go to review food
  ///
  void gotoReviewFood(String idOrder){
     Get.toNamed(FillRatingRoutes.REVIEW_FOOD,arguments:  idOrder);
  }
}
