import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/voucher/voucher.dart';
import 'package:fooding_project/repository/voucher_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VoucherController extends GetxController {
  final VoucherRepository _voucherRepository = GetIt.I.get<VoucherRepository>();
  bool isLoading = true;
  List<Voucher> listVouchers = [];
  TextEditingController textvoucher = TextEditingController();
  double? price;
  String? idStore;
  int index = -1;
  RefreshController refreshController = RefreshController();
  @override
  void dispose() {
    super.dispose();
    textvoucher.dispose();
    refreshController.dispose();
  }

  @override
  void onInit() {
    super.onInit();

    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      price = Get.arguments[0] as double;
      idStore = Get.arguments[1] as String;
      getAllVoucher();
    }
  }

  ///
  /// Get all voucher.
  ///
  Future<void> getAllVoucher() async {
    listVouchers.clear();
    await _voucherRepository.getAllVoucherStoreAndApp(
      idStore: idStore!,
      onSuccess: (onSuccess) {
        listVouchers = onSuccess;
        isLoading = false;
        refreshController.refreshCompleted();
        update();
      },
      error: (e) {
        IZIAlert().error(message: e.toString());
      },
    );
  }

  ///
  /// Find voucher.
  ///
  Future<void> findcodeVoucher() async {
    await _voucherRepository.findCodeVoucher(
        onSuccess: (onSuccess) {
          if (onSuccess.idStore == idStore) {
            IZIAlert().success(message: "Áp dụng voucher thành công");
            Get.back(result: onSuccess);
          } else {
            IZIAlert().error(message: "Không áp dụng được voucher này");
          }
        },
        error: (e) {
          IZIAlert().error(message: e.toString());
        },
        code: textvoucher.text);
  }

  ///
  /// On Click ListView
  ///
  void onClickListView(int index) {
    if (index == -1) {
      IZIAlert().error(message: "Bạn chưa chọn mã giảm giá");
      return;
    }
    if (listVouchers[index].minOrderPrice! > price!) {
      IZIAlert()
          .error(message: "Bạn không đủ điều kiện để sử dụng voucher này");
    } else {
      Get.back(result: listVouchers[index]);
      IZIAlert().success(message: "Bạn sử dụng mã giảm giá thành công");
    }
  }

  ///
  /// See more.
  ///
  void seeMore(int index) {
    Get.defaultDialog(
        content: Text(listVouchers[index].description!), title: "Voucher");
  }
}
