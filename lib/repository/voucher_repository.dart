import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooding_project/model/voucher/voucher.dart';

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
      onSuccess(query.docs.map((e) => Voucher.fromMap(e.data())).toList());
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
        onSuccess(Voucher.fromMap(query.docs.first.data()));
      } else {
        error("Không tìm thấy voucher");
      }
    } catch (e) {
      error(e);
    }
  }
}
