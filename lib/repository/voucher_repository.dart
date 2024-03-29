import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/voucher/voucher.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';

class VoucherRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  ///
  /// Get all Voucher.
  ///
  Future<void> getAllVoucher({
    required Function(List<Voucher> onSuccess) onSuccess,
    required Function(dynamic e) error,
  }) async {
    try {
      final query = await _fireStore
          .collection("vouchers")
          .where("isDeleted", isEqualTo: false)
          .where("isShow", isEqualTo: true)
          .get();
      List<Voucher> listTemps = [];
      for (final element in query.docs) {
        final voucher = Voucher.fromMap(element.data());
        print(voucher.toJson());
        if (!voucher.listCustomer!
                .contains(sl<SharedPreferenceHelper>().getIdUser) &&
            voucher.limitMax! > voucher.listCustomer!.length &&
            voucher.endDate!.millisecondsSinceEpoch >
                DateTime.now().millisecondsSinceEpoch) {
          listTemps.add(voucher);
          print("123");
        }
      }
      onSuccess(listTemps);
    } catch (e) {
      error(e);
    }
  }

  ///
  /// Find code voucher.
  ///
  Future<void> findCodeVoucher({
    required Function(Voucher onSuccess) onSuccess,
    required Function(dynamic e) error,
    required String code,
  }) async {
    try {
      final query = await _fireStore
          .collection("vouchers")
          .where("code", isEqualTo: code)
          .where("isShow", isEqualTo: false)
          .where("isDeleted", isEqualTo: false)
          .get();
      if (query.docs.isNotEmpty) {
        for (final element in query.docs) {
          final voucher = Voucher.fromMap(element.data());
          print(voucher.toJson());
          if (!voucher.listCustomer!
                  .contains(sl<SharedPreferenceHelper>().getIdUser) &&
              voucher.limitMax! > voucher.listCustomer!.length &&
              voucher.endDate!.millisecondsSinceEpoch >
                  DateTime.now().millisecondsSinceEpoch) {
            onSuccess(voucher);
            return;
          }
        }
      } else {
        error("Không tìm thấy voucher");
      }
    } catch (e) {
      error(e);
    }
  }

  ///
  /// Add voucher.
  ///
  Future<void> addidCustomerToVoucher({
    required String idvoucher,
    required Function() onSuccess,
    required Function(dynamic e) error,
  }) async {
    try {
      await _fireStore.collection("vouchers").doc(idvoucher).update({
        "listCustomer":
            FieldValue.arrayUnion([sl<SharedPreferenceHelper>().getIdUser])
      });
      onSuccess();
    } catch (e) {
      error(e);
    }
  }

  ///
  /// Get all Voucher.
  ///
  Future<void> getAllVoucherStoreAndApp({
    required String idStore,
    required Function(List<Voucher> onSuccess) onSuccess,
    required Function(dynamic e) error,
  }) async {
    try {
      final query = await _fireStore
          .collection("vouchers")
          .where("isDeleted", isEqualTo: false)
          .where("isShow", isEqualTo: true)
          .get();
      List<Voucher> listTemps = [];
      for (final element in query.docs) {
        final voucher = Voucher.fromMap(element.data());

        if (!voucher.listCustomer!
                .contains(sl<SharedPreferenceHelper>().getIdUser) &&
            voucher.limitMax! > voucher.listCustomer!.length &&
            voucher.endDate!.millisecondsSinceEpoch >
                DateTime.now().millisecondsSinceEpoch) {
          if (IZIValidate.nullOrEmpty(voucher.idStore)) {
            listTemps.add(voucher);
          } else if (voucher.idStore == idStore) {
            listTemps.add(voucher);
          }
        }
      }
      onSuccess(listTemps);
    } catch (e) {
      error(e);
    }
  }
}
