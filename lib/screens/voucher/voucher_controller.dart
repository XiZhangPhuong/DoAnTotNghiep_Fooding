import 'package:flutter/material.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/voucher/voucher.dart';
import 'package:fooding_project/repository/voucher_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class VoucherController extends GetxController {
  final VoucherRepository _voucherRepository = GetIt.I.get<VoucherRepository>();
  bool isLoading = true;
  List<Voucher> listVouchers = [];
  TextEditingController textvoucher = TextEditingController();
  double? price;
  int index = -1;
  @override
  void dispose() {
    super.dispose();
    textvoucher.dispose();
  }

  @override
  void onInit() {
    super.onInit();

    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      price = Get.arguments as double;
    }
    getAllVoucher();
  }

  ///
  /// Get all voucher.
  ///
  Future<void> getAllVoucher() async {
    await _voucherRepository.getAllVoucher(
      onSuccess: (onSuccess) {
        listVouchers = onSuccess;
        isLoading = false;
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
          IZIAlert().success(message: "Áp dụng voucher thành công");
          Get.back(result: onSuccess);
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
}
