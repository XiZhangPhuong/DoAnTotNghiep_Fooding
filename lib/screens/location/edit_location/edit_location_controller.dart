import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import '../../../base_widget/izi_alert.dart';
import '../../../helper/izi_validate.dart';
import '../../../model/location/location_response.dart';
import '../../../repository/user_repository.dart';

class EditLocationController extends GetxController {
  //
  // Declare API.
  final UserRepository _userRepository = GetIt.I.get<UserRepository>();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();

  String? latLong;
  String? idLocation = Get.arguments as String? ?? "";
  bool isLoading = true;
  @override
  void dispose() {
    super.dispose();
    addressEditingController.dispose();
    phoneEditingController.dispose();
    nameEditingController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    findLocation();
  }

  ///
  /// Check phone Location.
  ///
  Future<bool> checkPhoneLocation() async {
    bool isFlag = false;
    await _userRepository.checkPhoneLocation(
      phone: phoneEditingController.text,
      onSucces: (isPhone) {
        if (IZIValidate.nullOrEmpty(isPhone)) {
          isFlag = false;
        } else {
          isFlag = true;
        }
      },
      onError: (error) {
        isFlag = false;
        print(error.toString());
      },
    );
    return isFlag;
  }

  ///
  /// Validate add address.
  ///
  Future<bool> _validateAddAddress() async {
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
    if (await checkPhoneLocation() == false) {
      IZIAlert().error(message: "Số điện thoại đã trùng");
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

  ///
  /// Find Location.
  ///
  void findLocation() {
    _userRepository.finLocation(
      idLocation: idLocation!,
      onSucces: (loctions) {
        if (!IZIValidate.nullOrEmpty(loctions)) {
          phoneEditingController.text = loctions.phone!;
          nameEditingController.text = loctions.name!;
          addressEditingController.text = loctions.address!;
          latLong = loctions.latlong!;
          isLoading = false;
          update();
        }
      },
      onError: (error) {
        print(error.toString());
      },
    );
  }

  ///
  /// update location.
  ///
  Future<void> updateLocation() async {
    if (await _validateAddAddress()) {
      EasyLoading.show(status: "Đang cập nhật vị trí");
      LocationResponse request = LocationResponse(
        address: addressEditingController.text,
        latlong: latLong,
        name: nameEditingController.text,
        phone: phoneEditingController.text,
      );
      EasyLoading.show(status: "Đang cập nhật dữ liệu");
      _userRepository.updateLocation(
        id: idLocation!,
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
}
