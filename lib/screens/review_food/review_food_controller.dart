import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/model/comment/comment_request.dart';
import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/model/product/products.dart';
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

class ReviewFoodController extends GetxController {
  String idOrder = '';
  OrderResponse orderResponse = OrderResponse();
  User userResponse = User();
  List<CommentRequets> listComment = [];
  final OrderResponsitory _orderResponsitory = GetIt.I.get<OrderResponsitory>();
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();
  final CommentRepository _commentRepository = GetIt.I.get<CommentRepository>();
  bool isLoading = false;
  bool isLoadingComment = false;
  List<bool> checkOrder = [];

  @override
  void onInit() {
    super.onInit();
    idOrder = Get.arguments as String;
    findOrder();
    
  }

  ///
  /// find Order
  ///
  Future<void> findOrder() async {
    await _orderResponsitory.findOrder(
      idOrder: idOrder,
      onSuccess: (order) async {
        orderResponse = order;
        userResponse = await getUser(orderResponse.idEmployee!);
        getAllComment(orderResponse.id!);
        isLoading = true;
        update();
      },
      onError: (erorr) {},
    );
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
  void gotoEvaluateProduct(
      String idOrder, String idProduct, String idShipper, String type) {
    Get.toNamed(DetailOrderRoutes.EVALUATE,
        arguments: [idOrder, idProduct, idShipper, type]);
  }

  ///
  /// get List Comment
  ///
  Future<void> getAllComment(String idOrder) async {
    _commentRepository.get(
      idOrder: idOrder,
      idUser: sl<SharedPreferenceHelper>().getIdUser,
      onSuccess: (data) {
        listComment = data;
        isLoadingComment = true;
        print(listComment.length.toString());

        update();
      },
      onError: (e) {
        print(e);
      },
    );
  }

  ///
  /// checkEvaluateShipper
  ///

  bool checkEvaluateShipper(
      List<CommentRequets> listCommentRequest, OrderResponse orderResponse) {
    for (final i in listCommentRequest) {
      if (i.typeUser == 'SHIPPER') {
        if (orderResponse.id == i.idOrder! &&
            orderResponse.idEmployee == i.idShipper) {
          return true;
        }
      }
    }
    return false;
  }

  ///
  /// checkEvaluateProduct
  ///

  List<bool> checkEvaluateProduct(
      List<CommentRequets> listCommentRequest, OrderResponse orderResponse) {
    List<bool> listCheck =
        List.generate(orderResponse.listProduct!.length, (index) => false);
    for (final i in listCommentRequest) {
      if (i.typeUser == 'PRODUCT' && i.idOrder == orderResponse.id!) {
        for (final currentIndex in orderResponse.listProduct!) {
          if (currentIndex.id == i.idProduct) {
            listCheck[orderResponse.listProduct!.indexOf(currentIndex)] = true;
          }
        }
      }
    }
    return listCheck;
  }
}
