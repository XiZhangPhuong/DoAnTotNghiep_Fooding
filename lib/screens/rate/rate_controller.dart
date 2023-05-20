import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/model/user.dart';
import 'package:fooding_project/screens/SHIPPER/home_shipper/home_shipper_controller.dart';
import 'package:fooding_project/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class RateController extends GetxController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  TextEditingController editingController = TextEditingController();
  List<File> listImageFile = [];
  List<String> arguments = [];
  User user = User();

  ///
  /// Pick avatar.
  ///
  Future<void> pickAvatar() async {
    final images = await ImagePicker().pickImage(source: ImageSource.camera);
    if (images == null) return;
    listImageFile.add(File(images.path));
    update();
  }

  // upload firesore list image string
  Future<List<String>> uploadImagesToStorage(List<File> images) async {
    List<String> downloadUrls = [];

    for (File image in images) {
      Reference ref =
          _storage.ref().child('orderPicture').child(const Uuid().v1());
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
  }

  ///
  /// On click handle.
  ///
  Future<void> onClickHandle() async {
    if (handleValidate()) {
      try {
        EasyLoading.show(status: "Đang cập nhật dữ liệu");
        final ctlShiper = Get.find<HomeShipperController>();
        OrderResponse orderResponse = OrderResponse();
        orderResponse.id = arguments[0];
        orderResponse.listImage = await uploadImagesToStorage(listImageFile);
        if (arguments[1] == CANCEL) {
          orderResponse.statusOrder = CANCEL;
        }
        await ctlShiper.updateStatusOrder(orderResponse: orderResponse);
        IZIAlert().success(message: "Cập nhật thành công");
        EasyLoading.dismiss();
        Get.back(result: "Hello");
      } catch (e) {
        IZIAlert().error(message: "Vui lòng thử lại sau");
        EasyLoading.dismiss();
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      arguments = Get.arguments as List<String>;
    }
  }

  ///
  /// handle list.
  ///
  bool handleValidate() {
    if (editingController.text.isEmpty) {
      IZIAlert().error(message: "Vui lòng nhập lý do ");
      return false;
    }
    if (listImageFile.isEmpty) {
      IZIAlert().error(message: "Vui lòng thêm ảnh");

      return false;
    }
    return true;
  }
}
