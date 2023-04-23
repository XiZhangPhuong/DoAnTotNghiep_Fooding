import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/location/location_response.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

class AddLocationController extends GetxController {
  //
  // Declare API.
  UserRepository _userRepository = GetIt.I.get<UserRepository>();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();

  String? latLong;
  @override
  void dispose() {
    super.dispose();
    addressEditingController.dispose();
    phoneEditingController.dispose();
    nameEditingController.dispose();
  }

  ///
  /// Add location on Firebase.
  ///
  void addLocation() {
    if (_validateAddAddress()) {
      LocationResponse request = LocationResponse(
        id: Uuid().v1(),
        address: addressEditingController.text,
        latlong: latLong,
        name: nameEditingController.text,
        phone: phoneEditingController.text,
      );
      EasyLoading.show(status: "Đang cập nhật dữ liệu");
      _userRepository.addLocation(
        request: request,
        onSucces: () {
          IZIAlert().success(message: "Thêm địa chỉ thành công");
          EasyLoading.dismiss();
          Get.back();
        },
        onError: (error) {
          IZIAlert().error(message: "Thêm địa chỉ thất bại");
          EasyLoading.dismiss();
          print(error.toString());
        },
      );
    }
  }

  ///
  /// Validate add address.
  ///
  bool _validateAddAddress() {
    if (nameEditingController.text.isEmpty) {
      IZIAlert().error(message: "Tên của đang để trống");
      return false;
    }
    if (phoneEditingController.text.isEmpty) {
      IZIAlert().error(message: "Số điện thoại đang để trống");
      return false;
    }
    if (phoneEditingController.text.length != 10) {
      IZIAlert().error(message: "Số điện thoại phải là 10 chữ số");
      return false;
    }
    if (!IZIValidate.phoneNumber(phoneEditingController.text)) {
      IZIAlert().error(message: "Số điện thoại không đúng định dạng");
      return false;
    }
    if (addressEditingController.text.isEmpty) {
      IZIAlert().error(message: "Địa chỉ đang để trống");
      return false;
    }
    if (IZIValidate.nullOrEmpty(latLong)) {
      IZIAlert().error(message: "Vui lòng chọn lại địa chỉ");
      return false;
    }
    return true;
  }
}
