// ignore_for_file: avoid_print

import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/repository/order_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class FeelRatingController extends GetxController {
  bool isLoadingOrder = false;
  List<OrderResponse> listOrder = [];
  int countProduct = 0;
  final OrderResponsitory _orderResponsitory = GetIt.I.get<OrderResponsitory>();

  @override
  void onInit() {
    super.onInit();
    _getProductOrder();
  }

  ///
  /// get order
  ///
  Future<void> _getProductOrder() async {
    _orderResponsitory.getAllOrderByStatus(
      onSuccess: (onSuccess) {
        listOrder = onSuccess;
        for (int i = 0; i < listOrder.length; i++) {
          if (listOrder[i].listProduct != null) {
            countProduct += listOrder[i].listProduct!.length;
          }
        }
        print(countProduct.toString());
        print('vanvanphuong');
        print(listOrder.length.toString());
        isLoadingOrder = true;
        update();
      },
      onError: (erorr) {
        print(erorr);
      },
    );
  }
}
