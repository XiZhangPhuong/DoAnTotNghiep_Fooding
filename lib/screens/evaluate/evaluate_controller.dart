// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fooding_project/base_widget/izi_alert.dart';
import 'package:fooding_project/di_container.dart';
import 'package:fooding_project/helper/izi_validate.dart';
import 'package:fooding_project/model/comment/comment_request.dart';
import 'package:fooding_project/model/order/order.dart';
import 'package:fooding_project/repository/comment_repository.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class EvaluateController extends GetxController{
  OrderResponse orderResponse = Get.arguments as OrderResponse;
  final CommentRepository _commentRepository =  GetIt.I.get<CommentRepository>();
  TextEditingController editingController = TextEditingController();
  bool satisFied  = true;
  double countRating = 0;
  File? imageFile;
   @override
  void onInit() {
    
    super.onInit();
    print(orderResponse.toMap());

  }

   ///
  /// Pick avatar.
  ///
  Future<void> pickAvatar() async {
    final images = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (images == null) return;
    imageFile = File(images.path);
    update();
  }



  ///
  /// click rating bar
  ///
  void clickRatingBar(double value){
     countRating = value;
     update();
  }


  ///
  /// post Comment
  ///
  void postComment(){
    if(countRating==0){
      IZIAlert().error(message: 'Bạn chưa chọn số sao');
      return;
    }
  EasyLoading.show(status: 'Đang cập nhập');
    final CommentRequets _commentRequest = CommentRequets();
    _commentRequest.idUser = sl<SharedPreferenceHelper>().getIdUser;
    _commentRequest.idStore = orderResponse.listProduct![0].idUser!;
    _commentRequest.idOrder = orderResponse.id;
    IZIValidate.nullOrEmpty(editingController.text) ? '' :
    _commentRequest.content = editingController.text;
    _commentRequest.rating = countRating;
    _commentRepository.addComment(request:
      _commentRequest
     , onSucces: (
      
     ) {
      EasyLoading.dismiss();
      
      IZIAlert().success(message: 'Đánh giá thành công');
      Get.back();
    },  onError: (error) {
       print(error);
    },);
  }
}