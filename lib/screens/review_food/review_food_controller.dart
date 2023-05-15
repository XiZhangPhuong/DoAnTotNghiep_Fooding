

import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/comment/comment_request.dart';
import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/repository/comment_repository.dart';
import 'package:fooding_project/repository/order_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/routes/routes_path/detail_order_routes.dart';
import 'package:fooding_project/routes/routes_path/fell_rating_routes.dart';
import 'package:fooding_project/screens/feel_rating/feel_rating_cotroller.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../model/user.dart';

class ReviewFoodController extends GetxController{
   String idOrder = Get.arguments as String;
   OrderResponse orderResponse = OrderResponse();
   User userResponse = User();
   List<CommentRequets> listComment = [];
  final OrderResponsitory _orderResponsitory = GetIt.I.get<OrderResponsitory>();
  final UserRepository _userRepository  =  GetIt.I.get<UserRepository>();
  final CommentRepository _commentRepository = GetIt.I.get<CommentRepository>();
  bool isLoading = false;
  List<bool> checkOrder = []; 

   @override
  void onInit() {
   
    super.onInit();
    _findOrder();
;
  
  }

  ///
  /// find Order
  ///
   Future<void> _findOrder() async {
   await _orderResponsitory.findOrder(idOrder: idOrder, onSuccess: (order) async {
         orderResponse = order;
         print(orderResponse.toMap());
         userResponse = await  getUser(orderResponse.idEmployee!);
         getAllComment(orderResponse.id!);
          checkOrderProduct();
         isLoading = true;
         update();
     }, onError: (erorr) {
       
     },);
   }

   ///
   /// get user by id
   ///
   Future<User> getUser(String idUser) async {
     return await _userRepository.findbyId(idUser: idUser);
   }

   ///
   /// go to evaluate product
   ///
   void gotoEvaluateProduct(String idOrder,String idProduct,String idShipper){
    Get.toNamed(DetailOrderRoutes.EVALUATE,arguments: [idOrder,idProduct,idShipper]);
  }

  ///
  /// get List Comment
  ///
  void getAllComment(String idOrder){
    _commentRepository.get(
      idOrder: idOrder,
      idUser: sl<SharedPreferenceHelper>().getIdUser, onSuccess: (data) {
        listComment = data;
        update();
    }, onError: (e) {
      print(e);
    },);
  }

  ///
  /// checkOrder
  ///
 void checkOrderProduct() {
   checkOrder = List.generate(orderResponse.listProduct!.length, (index) => false);

  for (int i = 0; i < orderResponse.listProduct!.length; i++) {
    for (int j = 0; j < listComment.length; j++) {
      if (orderResponse.id == listComment[j].idOrder && orderResponse.listProduct![i].id == listComment[j].idProduct) {
        checkOrder[i] = true;
        break;
      }
    }
    for(final i in checkOrder){
      print(i.toString());
    }
  }


}


}


